From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Notes are independent: proposal for new notes  implementation
Date: Tue, 9 Feb 2010 21:55:28 +0100
Message-ID: <201002092155.29304.jnareb@gmail.com>
References: <201002092105.25636.jnareb@gmail.com> <32541b131002091226p58b40237j40d3cd6cfaa91df5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nex7v-0003Dx-7z
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 21:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0BIUzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 15:55:31 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:65446 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0BIUzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 15:55:31 -0500
Received: by fxm20 with SMTP id 20so528150fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FhnLN8OYSf0IRIg6S6+Qccq0+WRpxhYlVHnsjObBRpA=;
        b=WyeAr2h2y+Gg8upVMwbIo7/TmmqcZDxY5qP9q09IttrIBms+EdhGXkCA6rvANEzaOl
         ge/ko1O08PdtD01F1k8qoo2aIj+I+SfbG3PF4/somgv4220A2EskO9eJ3tFR+0L0EsGo
         z1RTL3P14z+875rdTAStHDikI8fDfzVkc+U90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=L+ywt7aS7l2ACT5E1ldkgK2HprGJCsebWNII5U1hCh3S0/9tJK9qN429Hz4qCoeZ9Z
         WqTbs7jLPwSv8sSFYX4ZFLmkS+TXLe9fPrWKiqhyoNYMvUFzSfpYC9bgVuxGLOV96NNL
         wBcaIG9LHiWOgQooNFZK+O/NMSRNK2X+CeyqI=
Received: by 10.223.143.15 with SMTP id s15mr7155135fau.48.1265748929531;
        Tue, 09 Feb 2010 12:55:29 -0800 (PST)
Received: from ?192.168.1.13? (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 28sm916393fkx.28.2010.02.09.12.55.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 12:55:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <32541b131002091226p58b40237j40d3cd6cfaa91df5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139441>

On Tue, 9 Feb 2010, Avery Pennarun wrote:
> 2010/2/9 Jakub Narebski <jnareb@gmail.com>:

> > But
> > what if the answer was to change implementation, decoupling history of
> > notes from each other, and keeping history of each note separate.
> 
> Congratulations, you've re-invented CVS! :)
> 
> Seriously though, I'm not sure what problems this solved.  Notes that
> are related to each other can (and perhaps should) be in the same
> notes commit history; notes that are not related to each other can
> exist in separate histories with their own ref.

The problem is (as I see it) that notes are _not_ (in almost all cases)
related to each other, just like files in $HOME or in /etc are not
related to each other.  Separate notes refs for separate histories
are not IMHO a good solution: refs namespaces are about *kind* (flavor)
of notes: commits annotations, bisect, git-svn, apply-email, bugs / tickets,
etc. and each flavor (kind) of notes contain many independent notes.
 
This is opposed to workspace history, where history (in almost all cases)
makes sense only of all files, history of a project as a whole.

And of course we would have atomic commits, merge tracking, support for
renames etc., something like Zit[1]

[1]: http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Zit

> > This means for example that if in repository A somebody annotated
> > commits foo and bar creating notes in this order, and in repository B
> > somebody annotated bar and foo (creating notes in reverse order), then
> > merging those changes would require generating merge commit even if
> > those notes are identical.
> 
> That's a feature; now you have the true history of your notes, which
> is good for all the same reasons it's good in git.

No, you are introducing artificial ordering in something that is a bag,
unordered collection.

> Of course this whole line of reasoning could lead to questions like
> "can I rebase my notes history?" and "what about rebase -i" and "can I
> maintain a notes patch queue" and so on.

-- 
Jakub Narebski
Poland
