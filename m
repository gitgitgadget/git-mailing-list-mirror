From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Something is broken in repack
Date: Thu, 13 Dec 2007 17:29:56 +0100
Message-ID: <47615E04.8000400@gnu.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>	 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>	 <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>	 <alpine.LFD.0.99999.0712112057390.555@xanadu.home>	 <alpine.LFD.0.99999.0712120743040.555@xanadu.home> <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> <fjrj9k$n6k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gcc@gcc.gnu.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Dec 13 17:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qxE-000422-0o
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbXLMQaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756513AbXLMQaK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:30:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:57096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbXLMQaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:30:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so921068ugc.16
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=G6cAlApBUVlHaCYH6Ep5vr8SeXOPHJ3itpKu61rR7sY=;
        b=P/9AfSXk27yqUHYNLf4EZkkAHiDVC2s5i6UmcsnJ0OleIHN32grcFmxiMw5TZAsDVk+PXfWZmCLrgWlXV/mBgHFwp9sFF+y7ztBbz3wUc16NL1BmDUPXwvWBvqE511t35ZZ7+cAv+lYnAnBjmLzlcFDpjpYSuek999KksgxHvO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=P4urFOapYiBtgew8XL618H5drWBxyRH4abZK1QIzj8yJrPptaEHO0FurXAKSpGm984j6CP4CvW/NICo0S25CwQMK5Y41PHnAOxjcGWjW+915NULdtrE1PlgBNcnISP5kk0zVtFsNf17wB9u/VUo+0P+c1h/1SaoXdlVGvInTJg4=
Received: by 10.78.136.9 with SMTP id j9mr2590949hud.70.1197563406260;
        Thu, 13 Dec 2007 08:30:06 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id e9sm18606663muf.2007.12.13.08.29.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Dec 2007 08:29:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <fjrj9k$n6k$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68171>


>> Is there an alternative to "git repack -a -d" that repacks everything
>> but the first pack?
> 
> That would be a pretty good idea for big repositories.  If I were to 
> implement it, I would actually add a .git/config option like 
> pack.permanent so that more than one pack could be made permanent; then 
> to repack really really everything you'd need "git repack -a -a -d".

Actually there is something like this, as seen from the source of 
git-repack:

             for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
                      | sed -e 's/^\.\///' -e 's/\.pack$//'`
             do
                     if [ -e "$PACKDIR/$e.keep" ]; then
                             : keep
                     else
                             args="$args --unpacked=$e.pack"
                             existing="$existing $e"
                     fi
             done

So, just create a file named as the pack, but with extension ".keep".

Paolo
