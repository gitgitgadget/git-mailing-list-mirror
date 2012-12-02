From: Shawn Pearce <spearce@spearce.org>
Subject: Re: does a successful 'git gc' imply 'git fsck'
Date: Sat, 1 Dec 2012 20:28:34 -0800
Message-ID: <CAJo=hJvHeA4g1fJZXm9VxpdvMFoHeEJW_r5YtXTDACEp09Xm_Q@mail.gmail.com>
References: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 05:29:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf1B6-0000VP-PK
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 05:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab2LBE25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 23:28:57 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:62607 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2LBE24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 23:28:56 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1396680iay.19
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 20:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GK24JD0/HxQSNeaJvtzWc/4JsPH8tRdfClAjrvVA9og=;
        b=TbCft2qILC+svNXBQkmW5LgQkXVLQlo02a97/JzDIfp6GtF2wQLVg+z92J57LAmLNR
         pkUP358qozLW/T6tnWIgutDh95OdPiMOBzCmqVSPAqaTyejgpUaDUJugwPS95fgV6zgB
         KAtIqouon/FLu/kcIzxPfb6spVjLEnRpCL3UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=GK24JD0/HxQSNeaJvtzWc/4JsPH8tRdfClAjrvVA9og=;
        b=QNzOej+br7AvrmOB8d3YwIjxWUVZ7hwoKWpzC9VpqbRVgFAVDh0DxdBiJKF6irNqgp
         tV5Mcm/vqrFfsh/6P4iILnm9iPQSObAsDZGPSXH7TGwA7x2aOyWogqVFIBZUfMLaqKaD
         ljueh+ZsOwmQTZimvBwpN7hb6U+A8AK2yqE/EOTmdmeyihDPWKLa1Md9rZAfIhZFSKc9
         l+oSgJivcruuGm2a/RmjLlrwQhWHLgNiYr7x3t2E3AlS4U1LJRqJ71l5sWuLZOAjmQ1Q
         TudYSKIWR8G5cicu4a36CI5ZbxANsfLJa6FqRidlcKyFAm7NeOLvMGTIHgyQ6MiLkPjR
         inUg==
Received: by 10.50.16.129 with SMTP id g1mr2919651igd.43.1354422534898; Sat,
 01 Dec 2012 20:28:54 -0800 (PST)
Received: by 10.64.102.170 with HTTP; Sat, 1 Dec 2012 20:28:34 -0800 (PST)
In-Reply-To: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
X-Gm-Message-State: ALoCoQkTBygUzNMmcWGS7rkuMbtUnDFr3QXw4dj9MxT3IfHkACkmZf3ShQ0xnJDM+VpcQ4gXT4uv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211000>

On Sat, Dec 1, 2012 at 6:31 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Background: I have a situation where I have to fix up a few hundred
> repos in terms of 'git gc' (the auto gc seems to have failed in many
> cases; they have far more than 6700 loose objects).  I also found some
> corrupted objects in some cases that prevent the gc from completing.
>
> I am running "git gc" followed by "git fsck".  The majority of the
> repos I have worked through so far appear to be fine, but in the
> larger repos (upwards of 2-3 GB) the git fsck is taking almost 5 times
> longer than the 'gc'.
>
> If I could assume that a successful 'git gc' means an fsck is not
> needed, I'd save a lot of time.  Hence my question.

Not really. For example fsck verifies that every blob when
decompressed and fully inflated matches its SHA-1. gc only checks
connectivity of the commit and tree graph by making sure every object
was accounted for. But when creating the output pack it only verifies
a CRC-32 was correct when copying the bits from the source to the
destination, it does not verify that the data decompresses and matches
the SHA-1 it should match.

So it depends on what level of check you need to feel safe.
