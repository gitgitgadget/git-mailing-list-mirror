From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 32/44] refs.c: remove the update_ref_write function
Date: Wed, 21 May 2014 15:07:10 -0700
Message-ID: <20140521220710.GG12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-33-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEfR-0006Rj-FX
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbaEUWHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:07:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38032 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbaEUWHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:07:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so1811503pab.15
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kpB/rtJBBX9y+el1Jf7DVXGUowZzHGNzBRAFSIBAHSI=;
        b=0RfamTyRInAMLvy/+KYhSyCYroMOs1yZuG+C6UIH73EQHOiTOMrSfO9HdoH8BfzBVK
         uCZIZvlFRvznbDbC/+A7iUKyG9eQ4Nd4APw/ZLZzkRDxzborXN4BnE/CgAxtCehOgMKC
         0KoeN5SsElBQsaLxx8wSy/3CGCO8Y1kJVz+okcXJQ8gUsSwmgccrc+OakhPXOMVEJYXk
         r9yIHZH3v/jA5l4wZIfEZ+MfRpMEMDSOHNwMYfwDXk3D9PKCoGZGNFU6IoW71BMCJzyu
         Tbwaa9WsQpRo2oH91pv3rIJJ+f/LuqICyImxaWLIAn6uS/VfroyXNOh10p9tYpmfl0QM
         bLXA==
X-Received: by 10.66.192.73 with SMTP id he9mr62307603pac.88.1400710032793;
        Wed, 21 May 2014 15:07:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pv4sm36809653pac.14.2014.05.21.15.07.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:07:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-33-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249846>

Ronnie Sahlberg wrote:

> +++ b/refs.c
[...]
> @@ -3518,14 +3499,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		struct ref_update *update = updates[i];
>  
>  		if (!is_null_sha1(update->new_sha1)) {
> -			ret = update_ref_write(msg,
> -					       update->refname,
> -					       update->new_sha1,
> -					       update->lock, err,
> -					       UPDATE_REFS_QUIET_ON_ERR);
> +			ret = write_ref_sha1(update->lock, update->new_sha1,
> +					     msg);

This changes the return value on error from 1 to -1.  That seems like a
good change.  It's probably worth mentioning in the commit message.
