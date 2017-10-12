Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC73120372
	for <e@80x24.org>; Thu, 12 Oct 2017 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdJLR7b (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 13:59:31 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:46085 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdJLR7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 13:59:30 -0400
Received: by mail-oi0-f50.google.com with SMTP id n82so9786819oig.3
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IA9X5aW6l3s5J+4SnzG1u0Yzqlk8Yibdmx2QENkuvW8=;
        b=wlEcyQdvs97HdGrYCi0HjQ7KsOLxID6MasQEZuaAhYxprJydEkUkxnccwJcKRI+1j+
         SegTjJ+gzs3uXg0/gENBYQPobxonaem73o9CMIfeSAYBFfgiOJvSDg0rhd7QlZC4pIvA
         3Wj/EceuKNxNDgYQ0WslnP3MZ36o4MFTWhz5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IA9X5aW6l3s5J+4SnzG1u0Yzqlk8Yibdmx2QENkuvW8=;
        b=ed6MXKclsdHNEkTwFNLQj4N9aP2cB2YJeoA76CBPnLDsg4hgvAhyEu09A9SFu3T4Dm
         OHC3OfLIF/YaEKwyTxDaUCTwHR10cgs34Lhivi7QqWAz90IunvcJG/7JHVOYvCZ1/RE7
         dCPaViT4OPBImjb76DIK411r4Q1AxnyYjbKnuSdAdDxVLSet6srCI34zDvwxPDaVznTf
         6diepIUZ8zLF1MnVsh7fJg1kkKvuBgtj0fm17Ma2Z62IDMt6djMBag8YDp8gEgWCnuza
         7a14u5AF11U+9+l/909m9Jq8ww5w/buFHy2dH5HhVDeEgcWHQk2yqbq+iJ/38lkk9UYI
         5FQg==
X-Gm-Message-State: AMCzsaVtAV6KEWlhpqRq/8XVm+C5ltWIllMxS7EE9V8cvC5PjQT0h5lB
        ZI/BqTRAlfdDzkkfALab8UXOHBcPWRx8DCoMv0R+yTpp
X-Google-Smtp-Source: ABhQp+T4G1pJ7hOUC1QP4RSTBpe0JrI/isOfNlmKU6jZLW59eLSSoTAWsVfXfJ71yh6xne0UFQK8Uu25u6oITZ5T6NQ=
X-Received: by 10.157.44.174 with SMTP id p43mr2003468otb.378.1507831167166;
 Thu, 12 Oct 2017 10:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.11.17 with HTTP; Thu, 12 Oct 2017 10:59:06 -0700 (PDT)
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Thu, 12 Oct 2017 12:59:06 -0500
Message-ID: <CACcTrKctqAWeWWrc9Q+Y7ewXGc_o+uJoeHS83LDw5O_s1-3Nug@mail.gmail.com>
Subject: (Some?) control codes not escaped when using `git add -p`
To:     git@vger.kernel.org, Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

Running git 2.7.4, I=E2=80=99ve run into an issue where control codes that =
would
normally be escaped when using `git diff` are not similarly escaped when us=
ing
`git add -p`.

As a concrete example, I have a text file including the following "text":

:map ^[[H <Home>
:map ^[[5~ ^B "page up
:map ^[[6~ ^F "page down

Except each ^x above is the literal ctrl+x (i.e. ctrl+v followed by ctrl+x)=
.
These are not lines that have been added or removed from the document, they=
're
just context lines.

Using `git diff`, these special characters are elided from the diff output
(though the latter two lines cause special coloring in the diff output so
perhaps they're not being entirely escaped?), but when using `git add -p` u=
pon
reaching the chunk in question my terminal interprets a literal "page up" i=
nput
and corrupts the output.

Here's a screenshot of what I see when I use `git diff`:
https://i.imgur.com/FOXWEIi.png

And here's what I see when use `git add -p`:
https://i.imgur.com/i5hqhFX.png

As you can see, in the second example the cursor is a few lines from the to=
p of
the screen, as the text output started midway down and then jumped to the s=
tart
and continued from there on encountering the literal 'Page Up' sequence in =
the
diff'd text.

I'm not sure _what_ the correct approach would be here (does git faithfully
print whatever it finds in the file or does it attempt to escape it instead=
?)
but it seems to me that the lack of consistency between the two commands is=
 a
bug as whichever approach is taken, a context line in `git diff` should sur=
ely
be output to the terminal in the same way as a context line in `git add -p`=
?

The obvious solution is to embrace isatty(2) religiously, but I'm not
sure how the
everyone else feels about that (or if it's already used elsewhere).

Anyway, I'm sure I'm not the only one to run into this. Seeking options and
interested in the various viewpoints on how this should be correctly handle=
d
(or explanations for why it's already correct as-is).

Cheers,

Mahmoud Al-Qudsi
NeoSmart Technologies
