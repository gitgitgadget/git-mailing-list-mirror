From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 15:16:45 -0600
Message-ID: <20111118211645.GA27440@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <buor516m3w7.fsf@dhlpc061.dev.necel.com>
 <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
 <CACsJy8CKmjq01KoLRzOnnaf6RwFCQJfjxziqKTZW9HDyd8CagA@mail.gmail.com>
 <loom.20111118T191851-152@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 22:17:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRVnz-0003YI-PM
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 22:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab1KRVQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 16:16:59 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35940 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab1KRVQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 16:16:59 -0500
Received: by ywt32 with SMTP id 32so2929223ywt.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T4hLswdceYIGZkzqSE47N1A6GohZUMChSRv1lG8nF9A=;
        b=f2drOs2kE8V+kmFi8lPkMFz1zVPoSHrKoenVAzeGLNjN9w5uhaYTfJUsTwJ+jv8lSC
         AnhL7Dq6JKNb7oIrzn1Ba97gfvpvlXfJhpPrDBkbnDn6R0iLmJZeK/8rsJP6iHJtN/Q+
         ckGY9xFFNQk2sf92IinXlBl+42KK5LPgVaWKw=
Received: by 10.236.197.99 with SMTP id s63mr8054816yhn.14.1321651018483;
        Fri, 18 Nov 2011 13:16:58 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j25sm2455519yhm.12.2011.11.18.13.16.56
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 13:16:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20111118T191851-152@post.gmane.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185680>

Hi,

(restoring cc list.  Unfortunately gmane's web interface doesn't
 provide a built-in way to reply-to-all.  [1] has a hackish
 workaround.)
Samuel Bronson wrote:
> Nguyen Thai Ngoc Duy writes:

>> "gcc -MF depfile -MMD -MP -c -o path/to/file.o" will produce "depfile"
>> with target given by "-o". When ccache runs, it executes "gcc -MF
>> depfile -MMD -MP -E" instead to get the final content for hashing.
>> Notice that "-c -o" combination is replaced by "-E". The latter
>> produces target without leading path.
[...]
> I'm pretty sure you should report this against ccache; GCC seems to be
> behaving as documented.

Seems to have been fixed by v3.0pre0~187:

 commit e8354384
 Author: Andrea Bittau <a.bittau@cs.ucl.ac.uk>
 Date:   Sun Nov 1 19:39:58 2009 +0100

     Fix handling of the -MD and -MDD options

     From <http://lists.samba.org/archive/ccache/2007q2/000272.html>:

     The -MD and -MDD options automatically determine where the dependency file
     should land and what the target should look like based on the -o option.
     However, ccache drops -o and things mess up. The original patch was posted by
     Kaz Kylheku but I reworked it to make it work properly. Here is his post:

     http://lists.samba.org/archive/ccache/2006q4/000249.html

Workaround incoming in a few moments.

Thanks,
Jonathan
