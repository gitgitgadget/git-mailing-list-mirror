From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Sun, 14 Jun 2015 14:34:45 -0700
Message-ID: <xmqq4mmam0sq.fsf@gitster.dls.corp.google.com>
References: <55300D2C.9030903@web.de>
	<1429319946-19890-1-git-send-email-pclouds@gmail.com>
	<5533A567.7070301@web.de>
	<CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
	<xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>
	<CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
	<xmqq8udlgpey.fsf@gitster.dls.corp.google.com>
	<5537F31D.4090704@web.de>
	<xmqq1tjcdjfa.fsf@gitster.dls.corp.google.com>
	<5538218B.4010400@web.de>
	<CAPc5daUA30ZbbJVK9S_FM9Z8qyyEXUez9hGD2JNhTm78QYb5YQ@mail.gmail.com>
	<CACsJy8A5ikjGmj+ysTUt9FFi9X0WzVXvnFSVbmFoe8rzHdNNoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 23:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4FYO-0002Se-I7
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 23:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbFNVet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 17:34:49 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36246 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbFNVes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 17:34:48 -0400
Received: by igbiq7 with SMTP id iq7so5957748igb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mK4CEZlqcuolK0MX65kSBvqdTB8wjFOHKbZDhmkO9Jw=;
        b=QhcdiUECY5IRKCmRY3xeZezklEpbRj603ipQBx/YMoI/4fgIKYywhDBWpZwFO7rJ5G
         1i3/FZdT98Kpfx5Mm3pIT0wyhCMHaeIhOIbTd0LYk4IrGOWYCHnRkqH97StpDsLLtaS8
         P6C1V55xQMSY06OQ0NrUHo3z6iqGe3VBHVmj+iMiO0ZtPj3iMW3Y/QQeEh6xH0ZqO18h
         4j9d8VglAvdCSvqEyur1e/j9LYUq7xhkhWe3V0+0wHS+ExAv6lAq9fw9axvvLTnmGk3G
         +ixHFoNkod2vgvOW74Sxbpg16B+xZtiuCNfj/QrXjosfgq2oyDR4qGAUzExAEMlftBva
         VTPw==
X-Received: by 10.107.16.216 with SMTP id 85mr18139102ioq.69.1434317688284;
        Sun, 14 Jun 2015 14:34:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8cf8:478e:8162:753f])
        by mx.google.com with ESMTPSA id f82sm961171ioj.37.2015.06.14.14.34.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 14:34:47 -0700 (PDT)
In-Reply-To: <CACsJy8A5ikjGmj+ysTUt9FFi9X0WzVXvnFSVbmFoe8rzHdNNoA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 14 Jun 2015 20:16:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271652>

Duy Nguyen <pclouds@gmail.com> writes:

> I think we should stop the ok-to-replace feature when submodules are
> involved, we consider submdules much more valuable than symlinks.

Hmm, I am not sure "valuable" is a good criterion to decide what
should happen, though.

The push to use ".git" that is a file pointing at a repository that
is safely stored away is a move to make valuable submodule more
easily removable from the working tree without losing information,
so that we can remove it from the working tree when the user
instructs us to, just like we can remove a symlink safely without
losing information.  The only thing we need to be careful is that
that the path that corresponds to the index entry is not "dirty".
That is, for a symlink, if you make it point at something different
without doing "git add" it, you would lose that working-tree-only
change when we "kill" that symbolic link in order to replace it with
a regular directory.  For a submodule, if you have uncommitted
changes in the submodule working tree, you would lose that the same
way when we "kill" that submodule in order to replace that directory
as part of the superproject's working tree.

There may need some more safety implemented (i.e. how we detect the
"dirty"-ness and when we stop the operation based on that), but I
would imagine there is nothing fundamentally special about submodule
that does not apply to a symlink or a normal blob.
