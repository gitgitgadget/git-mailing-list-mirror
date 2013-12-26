From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: workaround for a bug in svn serf backend
Date: Thu, 26 Dec 2013 12:28:05 -0800
Message-ID: <20131226202805.GV20443@google.com>
References: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
 <1388059524-4864-1-git-send-email-rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Thu Dec 26 21:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwHXi-00044g-17
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 21:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab3LZU2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 15:28:09 -0500
Received: from mail-gg0-f180.google.com ([209.85.161.180]:48345 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab3LZU2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 15:28:08 -0500
Received: by mail-gg0-f180.google.com with SMTP id k1so1765580gga.39
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 12:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+oQhyRoGvzyHxdt0rjCCjzhYrOzKZme5KNUwQor5R2w=;
        b=lmAQSIjXSvVh+mmVN2jmEWQ9yw360lGpv1mpkzgPZRF4reH4mkAYoklKKI856at1Zy
         G1PAGBWQroqP2SYQ95oEFxSKHKvNpCHZDRMN3jrUyoNEsmgsCjxSrdlJJW3qAsxjxQyN
         KPGWRXh44XQbwMKc8cVaY1fS6JfFfu16jBwwsNRojvsQBQglx8bDc1NF0lKk0wGlYc6y
         F/Zk9SPmmBl8C+nrLz8DwlvNG1hYshipMXKs6ZbjWqVrWWhchz1JcmSImwtiFoQfsoTu
         WcO7Kc5giozFjQxx1GaaDXA9JJT5HN2lpTway65Nq0rcqQNczvIowQ9NAHrUdwPOtL5+
         3l7Q==
X-Received: by 10.236.42.231 with SMTP id j67mr3126897yhb.131.1388089688183;
        Thu, 26 Dec 2013 12:28:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q9sm43162519yhk.16.2013.12.26.12.28.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 12:28:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388059524-4864-1-git-send-email-rkagan@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239712>

Roman Kagan wrote:

> Subversion serf backend in versions 1.8.5 and below has a bug that the
> function creating the descriptor of a file change -- add_file() --
> doesn't make a copy of its 3d argument when storing it on the returned

3d makes me think of 3-dimensional. ;-)  I think you mean third
(or the abbreviation 3rd).

> descriptor.  As a result, by the time this field is used (in
> transactions of file copying or renaming) it may well be released.

Please describe the symptom so this patch is easy to find when other
people run into it.

Do I remember correctly that "... released and scribbled over with a
new value, causing such-and-such assertion to fire" was what happened?

> This patch works around this bug, by storing the value to be passed as
> the 3d argument to add_file() in a local variable with the same scope as
> the file change descriptor, making sure their lifetime is the same.

Could this be reproduced with a test script to make sure we don't
reintroduce the bug again later?  (It's okay if the test only fails on
machines with the problematic svn version.)

Modulo the confusing 3-dimensional arguments in comments, the code
change looks good.

Thanks and hope that helps,
Jonathan
