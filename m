From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Sun, 30 Aug 2015 09:49:22 +0100
Message-ID: <CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, technoweenie@github.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:49:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVyIs-0006sZ-Fi
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 10:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbbH3It0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 04:49:26 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33143 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbH3ItW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 04:49:22 -0400
Received: by oigm66 with SMTP id m66so45039822oig.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IXABXkorjTsEfv/E+F50P/jzEM8yo/G+fXs+5MCsx/8=;
        b=SeLbAu+btDrcatkgSy23YHCZNL2vzJdghCcKUJJqAO2tlj7k3oOrR+QzzG9f9pGbAx
         2AM7QP/7JeaM3LpAJwNHBp7bjxnr+G2W6qwZpQoMLMNs898WpbETSU75g6V4sPvj5f4w
         TaKVxu4NWu4QHIUuLh3rzGuD/V1t/7O0cNr9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IXABXkorjTsEfv/E+F50P/jzEM8yo/G+fXs+5MCsx/8=;
        b=fmGs5m+fYJh1bPQ5E1/pUvIMn1fA1+9MPPSeeNQniqqQJ/7uIIu/xxex03ngD4oe1P
         V/6sD2IaM9svUY7Puugy8r8CtE2VlMEtv1QqCG3etv4wDY6I64y/dXjs9CM0zmDTwjkZ
         i6f40UhzoqvL2nQY8brwGL4OhhssE+DHdP+gZS+mHsvekGPF/i25PgQ5JLkEIGkpWGT1
         mGjJWTBQGNCTD6vEAb9IH3jHcavmZmqLwaHqjQlyVLQNVxko3vZI4PWYof34sqA+UeiQ
         lyCh9DvtcfIq/Y1YClKEVoRYB1ZTmBf+EZ205gCtsi8n7vPQtqAnQ5GOdHUYFhunUY5n
         Lb1Q==
X-Gm-Message-State: ALoCoQmx3/vB1FWClplT9Z1GJ0knvbVyMAncTtE+10sIlurPKcXytYaOvvazoS5n7S4SDFmdtzeA
X-Received: by 10.202.175.143 with SMTP id y137mr10238290oie.22.1440924562148;
 Sun, 30 Aug 2015 01:49:22 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Sun, 30 Aug 2015 01:49:22 -0700 (PDT)
In-Reply-To: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276812>

On 28 August 2015 at 13:24,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> I am migrating huge Perforce repositories including history to Git. Some of them contain large files that would blow up the resulting Git repositories. This patch adds an option to store these files in Git LFS [1] on git-p4 clone.

I'm a bit worried by this. LFS isn't the only way to handle large
files in git - there's also git annex (which I've used in a similar
situation) and obviously random homebrew solutions. We're going to end
up with git-p4 sprouting ever increasing numbers of
--use-XXX-if-size-exceeds options. On the other hand, having it
integrated into git-p4 is quite nice as it saves a lot of messing
around.

Would it be possible as a start to have (within git-p4) a generic
spot-big-files-and-handle-them-differently patch, and a second patch
to add specific LFS support? That then means that other schemes would
be a lot easier to add in future.

Some other comments inline.

>
> In order to run the unit tests you need to install the Git LFS extension [2].
>
> Known limitations:
> The option "use-lfs-if-size-exceeds" looks at the uncompressed file size. Sometimes huge XML files are tiny if compressed. I wonder if there is an easy way to learn about the size of a file in a git pack file. I assume compressing it is the only way to know.
>
> Feedback is highly appreciated.
>
> Thank you,
> Lars
>
>
> [1] https://git-lfs.github.com/
> [2] https://github.com/github/git-lfs/releases/
>
> Lars Schneider (1):
>   git-p4: add option to store files in Git LFS on import
>
>  Documentation/git-p4.txt |  12 ++
>  git-p4.py                |  94 ++++++++++++++--
>  t/t9822-git-p4-lfs.sh    | 277 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 374 insertions(+), 9 deletions(-)
>  create mode 100755 t/t9822-git-p4-lfs.sh
>
> --
> 1.9.5 (Apple Git-50.3)

Can you switch to a newer git - this one's quite old now so if there
are regressions introduced later, you won't know about them!

>
