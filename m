From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 34/44] refs.c: make prune_ref use a transaction to
 delete the ref
Date: Wed, 21 May 2014 16:01:39 -0700
Message-ID: <20140521230139.GJ12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-35-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:01:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnFW7-00066q-Fm
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 01:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbaEUXBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 19:01:43 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48704 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaEUXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 19:01:42 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so1814431pdj.6
        for <git@vger.kernel.org>; Wed, 21 May 2014 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bhpOhoVVolIk1wi7w/PlzKOLGbKsHLKC942Ikt4V/LM=;
        b=PH1zmWXLZRbh6Lu/KHv75CYYYyqtY4LPelw9XHASXBEGoA9InwRuqM01OW9YxCzy0e
         O6JcRp2OtWji0M93XjFp3jXmex5Has0354ht/yir0+Jp1pRRsB55bLWwN8X1CIf6vAAa
         8AK6rDOh8BxFBcD6ssfLLfK1vPkU14ZA6k0sHA8MEOzjHpw8CrTOFWsPbr6Y9O29SuHp
         HQXcWvAlQn7hgpR+9CxakUTaXcxO0s+Boqkuloc11+dQ6Kol5Qo6GqhiCkiWf2Fb+/hz
         9aD/fDZolcYca0gtzM36n84KjVY5WApczMagbT3XYFBnPDAd3vOeFRI70TNgQkmnKiFh
         4lNw==
X-Received: by 10.66.180.168 with SMTP id dp8mr63455382pac.100.1400713302146;
        Wed, 21 May 2014 16:01:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bx5sm20112497pad.22.2014.05.21.16.01.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 16:01:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-35-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249857>

Ronnie Sahlberg wrote:

> Change prune_ref to delete the ref using a ref transaction. To do this we also
> need to add a new flag REF_ISPRUNING that will tell the transaction that we
> do not want to delete this ref from the packed refs.

Interesting.  Since the flag is per ref update, it even would allow
deleting some refs and pruning others in the same transaction.  Makes
sense.

Looks like this doesn't batch up multiple ref-prunings into a single
transaction.  Makes sense (it would just make the period while refs
are locked longer without having any real benefit).

[...]
> +#define REF_ISPRUNING	0x0100

Can this conflict with bit values declared elsewhere some day?  It
would be more comfortable if refs.h also had a note about bits >=
0x100 being reserved for private use.

The rest of the patch looks good.

Thanks,
Jonathan
