From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 04 Jul 2008 09:14:45 -0400
Message-ID: <486E2245.6040404@gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com> <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>	<486AC8E0.60002@verizon.net> <c376da900807031613pc63639du356946f8daeabb29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 15:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEl8e-00030f-6I
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbYGDNOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbYGDNOv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:14:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:55407 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbYGDNOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:14:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so805536waf.23
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pRIHRTCiJMT4HA1iS5wfbcS21C4sVIreAVCEAo0gng8=;
        b=r/QwO0CfNuQj2fb3P3Tydjg55PwtPo3kKh4Y6Vso/799flBnzWDDGk2QqdoIAF4kJa
         hyFf/xw397kyeiHBQusy6AKCjGiq+zku0gJsdiX2uWerlIeuINhTqHbtK7dtri10QRh0
         qTHqALmbb4zuFh0/gI/JNb1WGEF+Zg349yeRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wVeFCvEBtIiSrLGGHJw9XS3gbAgwoTm7f4VXUpe0HrEhlOivxwFh1XKRAnlRDXTEWT
         nctgfIxM2qUUNcj/bZ42IpHL3s6RP3+rZg7d6tpRaloOkSXyuL3kmoDhvHH/fwiUZ7Bq
         iU+fYqMjtN6Q6IBbmxlzsNEkwIj0vXRmtgTMM=
Received: by 10.114.15.1 with SMTP id 1mr3307554wao.184.1215177289854;
        Fri, 04 Jul 2008 06:14:49 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 5sm444802yxt.1.2008.07.04.06.14.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 06:14:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <c376da900807031613pc63639du356946f8daeabb29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87384>

Adam Brewster wrote:
> Hi Mark,
>
> Thank you for your help, and I'm sorry I didn't get back to you sooner.
>
> That's a good way to do things.  I tend to like my system better
> because it's a little more flexible and it doesn't pollute git-branch
> -a and gitk --all, also as I said before I like the bundle creation
> and the basis update to be separated.
>
> How do you deal with the case where you want to include remote refs in
> the bundle?  Don't they get saved as
> refs/remotes/remote/remotes/somewhere-else/master?
>
> Adam
>
>   
My script is based upon experience with breakage from keeping the basis 
separate: absent keeping the refs in the git repo, there is nothing to 
guarantee that the referenced commits continue to exist. We make 
extensive use of short lived topic branches that are often rebased 
multiple times before being incorporated into a stable branch, so an 
externally stored basis would frequently have invalid commits. The 
solutions to this are to 1) filter them out, one by one, with a "git 
rev-parse $commit" or some such, or 2) keep the refs in tree so git will 
not remove the objects.

I'm using this for sneaker-netting, so I know the bundles are being 
applied - clearly the create bundle and update in-tree basis steps could 
be separated, but I don't use this for cases where I'm not sure the 
bundle will be applied. In the latter case, I just use a basis 
containing only previous stable branches.

You are correct in the name for a remote in the pushed bundle, the names 
do get convoluted, but then I'm not sure what the "correct" syntax would 
be to refer to a remote repo's idea of a remote branch.

Mark
