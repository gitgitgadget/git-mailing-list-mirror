From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame (take 2)
Date: Tue, 3 Jun 2008 16:59:08 +0200
Message-ID: <b77c1dce0806030759w48045055if7636e950b14c977@mail.gmail.com>
References: <1212497890-4101-1-git-send-email-rgarciasuarez@gmail.com>
	 <484553E8.4050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 17:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Xzn-0000eR-3w
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 17:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYFCO70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYFCO70
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:59:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:33304 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbYFCO7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:59:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so824311ywe.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QTkuM9ei6H9zDLicIDTkAALY5tpX/jRhwFGx2Tm6GDQ=;
        b=mNWxV7V7sIMAklOO//wFsbh9O+Ln02Zq6HExC6vzrXSmEEDNPNCzB9XVH0eEdfJjt3WUteLuWhuXFJ1QBJX7Zwj0RpQfGo/cIGuDOyhaNLbzmPMB+grBLyaBpmqJND9lpka8yZVEoKHWMVQcnT44KYSu1F7SqcHH421GsuFLW5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MvPLp/SunhcWfmN7KKEn2oExaSgjbnGfYO5/jU7vgRpA1lrchW2cV5Us3phDw9wbpPZ7f6sNphNpaVUEMg3p5sLamX5Dcj2nemjuhCF+8xBsxne822+3M9rjiIzNnCx9F4IASL7u3Vaqfys6nWmcd5ubjEouWu6NuNS8Ao5jlRM=
Received: by 10.142.156.2 with SMTP id d2mr1102020wfe.271.1212505148908;
        Tue, 03 Jun 2008 07:59:08 -0700 (PDT)
Received: by 10.142.212.20 with HTTP; Tue, 3 Jun 2008 07:59:08 -0700 (PDT)
In-Reply-To: <484553E8.4050007@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83672>

2008/6/3 Lea Wiemann <lewiemann@gmail.com>:
> Rafael Garcia-Suarez wrote:
>>
>> Finally, to avoid forking git-rev-parse too many times, cache its
>> results in a new hash %parent_commits.
>
> I'm not too happy with this:
>
> 1) Minor point: I'm working on caching for the backend right now (IOW,
> basically what you're doing, just centralized in a separate module), so
> you're essentially duplicating work, and you're making it (a little) harder
> for me to refactor gitweb since I have to rip out your cache code.  Those
> few lines won't hurt, but in general I suggest that nobody make any larger
> efforts to cache stuff in gitweb for the next few weeks.

Sorry for that. I failed to consider that your work was applying there as well.

> 2) Major point: You're still forking a lot.  The Right Thing is to condense
> everything into a single call -- I believe "git-rev-list --parents --no-walk
> hash hash hash..." is correct and easily parsable. Its output seems to be
> lines of
>    hash parent_1 parent_2 ... parent_n
> with n >= 0.  Can you implement that?  It would be very useful and also
> reusable for me!

Ok, I see what you mean -- but I suppose that's the kind of
information that would be nicely abstracted out somewhere. At least I
would put it in a sub. And that sub would fit perfectly in your
caching module, too! Looking at the source, a generic git-rev-list
wrapper could be used.

If you want I can produce a patch against your version, but I'm afraid
I'll end up being a bit short on time, so I might be slow to do it.

> P.S.: I believe that the usual way to post follow-up patches is to label
> them [PATCH vN] for N >= 2 in the subject (since "take 2" shouldn't be part
> of the commit message), and to send them as In-reply-to a message in the
> original thread -- just provide git-send-email with the Message-ID of the
> message you want to reply to.  </nitpick>
>

Ok, noted. Also, next time, I'll send smaller patches.
