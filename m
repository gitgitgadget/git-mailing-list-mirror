Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A001A1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 15:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbdKMPeJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 10:34:09 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:54856 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdKMPeI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 10:34:08 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id EGkQe0MDkbjdZEGkQe4kY6; Mon, 13 Nov 2017 15:34:07 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=CEtC_dnCAAAA:8
 a=O9WNP3v1vAWXluaIBh0A:9 a=wPNLvfGTeEIA:10 a=Fr9QGtSrJqje8MTI1nyQ:22
Message-ID: <EEC5BA1D5F274F02AE20FC269868FDEF@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        "Git Mailing list" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1711120430580.30032@localhost.localdomain>
Subject: Re: more pedantry ... what means a file "known to Git"?
Date:   Mon, 13 Nov 2017 15:34:10 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171113-0, 13/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBtKTZPELjb+CBIGq/Ei/6FOkF8fuCiFAbCIMBDGib4SWUMqD1GpkpTd1a6nt91gUOP2QNior3jv78IT/n2PG9Zk+t+F7MPh2/zbW2j9g5eRfxwMEnzp
 lAJYgl8mvzLRBw79V9YMOIZuK6fhVgbXxdcc3OqB046bbcLjygPSn5s1kbLDA/4PHbX5V7aw1BW9dcSe6GCmGvlWAdcqQasP/Uc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert P. J. Day" <rpjday@crashcourse.ca>
>
>  apologies for more excruciating nitpickery, but i ask since it seems
> that phrase means slightly different things depending on where you
> read it.
>
>  first, i assume that there are only two categories:
>
>  1) files known to Git
>  2) files unknown to Git
>
> and that there is no fuzzy, grey area middle ground, yes?

sort of...
>
>  now, in "man git-clean", one reads (near the top):
>
>    Cleans the working tree by recursively removing files that are
>    not under version control, starting from the current directory.
>
>    Normally, only files unknown to Git are removed, but if the -x
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    option is specified, ignored files are also removed.
>
> the way that's worded suggests that ignored files are "known" to Git,
> yes?

You've hit the three way binary problem of +1, 0, -1 ! The lsb is still 0 or 
1, but we have the two assertions of:
Positively known to git -- added to the index and the object store
Negatively 'known' to git -- paths we actively ignore, thus not in the index 
or object store.

Unknown files are those that could be added.

>  that is, if, by default, "git clean" removes only files "unknown"
> to Git, and "-x" extends that to ignored files, the conclusion is that
> ignored files are *known* to Git.

but only in a negative sense ...

>
>  if, however, you check out "man git-rm", you read:
>
>    The <file> list given to the command can be exact pathnames,
>    file glob patterns, or leading directory names. The command
>    removes only the paths that are known to Git. Giving the name
>                                    ^^^^^^^^^^^^
>    of a file that you have not told Git about does not remove that file.
>
> so "git rm" removes only files "known to Git", but from the above
> regarding how "git clean" sees this, that should include ignored
> files, which of course it doesn't.

The man page description starts with the key "Remove files from the index", 
so this is the positive 'knowing' part. Clearly it can never remove other 
ignored files as they can't be in the index (but note the 'other' caveat. 
P->Q # Q->P).

>
>  given that this phrase occurs in a number of places:
>
> $ grep -ir "known to git" *
> builtin/difftool.c: /* The symlink is unknown to Git so read from the 
> filesystem */
> dir.c: error("pathspec '%s' did not match any file(s) known to git.",
> Documentation/git-rm.txt:removes only the paths that are known to Git. 
> Giving the name of
> Documentation/git-commit.txt:   be known to Git);
> Documentation/user-manual.txt:error: pathspec 
> '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known 
> to git.
> Documentation/gitattributes.txt: Notice all types of potential whitespace 
> errors known to Git.
> Documentation/git-clean.txt:Normally, only files unknown to Git are 
> removed, but if the `-x`
> Documentation/RelNotes/1.8.2.1.txt: * The code to keep track of what 
> directory names are known to Git on
> Documentation/RelNotes/1.8.1.6.txt: * The code to keep track of what 
> directory names are known to Git on
> Documentation/RelNotes/2.9.0.txt:   known to Git.  They have been taught 
> to do the normalization.
> Documentation/RelNotes/2.8.4.txt:   known to Git.  They have been taught 
> to do the normalization.
> Documentation/RelNotes/1.8.3.txt: * The code to keep track of what 
> directory names are known to Git on
> t/t3005-ls-files-relative.sh: echo "error: pathspec $sq$f$sq did not match 
> any file(s) known to git."
> t/t3005-ls-files-relative.sh: echo "error: pathspec $sq$f$sq did not match 
> any file(s) known to git."
> $
>
> it might be useful to define precisely what it means. or is it assumed
> to be context dependent?


A little bit of clarification may be useful. You can't be/aren't the only 
one who is willing to note these subtle inconsistencies (Git knows things 
via the index (staging area) and the object store (repository)).
>
> rday
--
Philip================= 

