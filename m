From: Junio C Hamano <gitster@pobox.com>
Subject: Re:
Date: Mon, 17 Aug 2015 10:49:08 -0700
Message-ID: <xmqqh9nxerfv.fsf@gitster.dls.corp.google.com>
References: <349031438778845@web22j.yandex.ru>
	<CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivan Chernyavsky <camposer@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:49:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZROX6-0008Ng-De
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 19:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbHQRtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 13:49:12 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36123 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbHQRtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 13:49:11 -0400
Received: by pdbmi9 with SMTP id mi9so17611458pdb.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rSVq7CTUIeZwGwMwCPdIhd9KbGuFvjfAVPogYDaBXjw=;
        b=H61JUiSVNUE+ee4bpJCteJ/v8RJR6RSS0ThRRwZwAh4lX+UCoOp27Zx/aYMWyEqsDz
         6Tqc1WOMgKa4xWFjw3UgHi9FZ9QC+5upgPyx+duVN6in6Ns7gp12JiS7HN0Rtr0yCuky
         AUyZdOjpQ3cKLNZyPnJCEzEkwIrBr17KBl5OU2z6G7ZYMLY80UnOJmuu6PSjKP1VLaWe
         fup5Yt7Mk7yRyM4HDMYtCjOnL9HxTNyscwDSZhWTes7NoDmLAM8wvnEVdiHWjJnBeXu/
         NuMfwdx97b6hn1mcisTLkstvC2rvujafgST359qBWNaHbXp+d5JlkTwN9rHHUoL7rywM
         G91Q==
X-Received: by 10.70.43.163 with SMTP id x3mr4760804pdl.151.1439833750637;
        Mon, 17 Aug 2015 10:49:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id ld8sm11968099pbc.61.2015.08.17.10.49.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 10:49:09 -0700 (PDT)
In-Reply-To: <CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 15 Aug 2015 16:19:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276063>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Aug 5, 2015 at 7:47 PM, Ivan Chernyavsky <camposer@yandex.ru> wrote:
>> Dear community,
>>
>> For some time I'm wondering why there's no "--grep" option to the
>> "git branch" command, which would request to print only branches
>> having specified string/regexp in their history.
>
> Probably because nobody is interested and steps up to do it. The lack
> of response to you mail is a sign. Maybe you can try make a patch? I
> imagine it would not be so different from current --contains code, but
> this time we need to look into commits, not just commit id.

That is a dangeous thought.  I'd understand if it were internally
two step process, i.e. (1) the first pass finds commits that hits
the --grep criteria and then (2) the second pass does "--contains"
for all the hits found in the first pass using existing code, but
still, this operation is bound to dig all the way through the root
of the history when asked to find something that does not exist.

>> So for example:
>>
>>     $ git branch -r --grep=BUG12345
>>
>> should be roughly equivalent to following expression I'm using now for the same task:
>>
>>     $ for r in `git rev-list --grep=BUG12345 --remotes=origin`; do git branch -r --list --contains=$r 'origin/*'; done | sort -u

You should at least feed all --contains to a single invocation of
"git branch".  They are designed to be OR'ed together.
