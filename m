Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199F81F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfGZUrW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:47:22 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:33482 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbfGZUrV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jul 2019 16:47:21 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2019 16:47:19 EDT
Received: from mxback12j.mail.yandex.net (mxback12j.mail.yandex.net [IPv6:2a02:6b8:0:1619::87])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 10E1511C2D48;
        Fri, 26 Jul 2019 23:40:52 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback12j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jmeCbNDDQS-ephWn1l9;
        Fri, 26 Jul 2019 23:40:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1564173651;
        bh=KN8trT9pSynUdHqasKdmqyFnmo1wNXGbnnajR25o7nk=;
        h=Message-Id:Cc:Subject:Date:References:To:From;
        b=ou8UyE3Uhbujw1mGfnoE8Yb6Jmf2Bs7e+Vs0YoOmM32rYrVPO+u9PBwLKjjNc7s0Z
         4W5nfU7niECHTupJydMVxrWFT5RUedGV5z+KjQXqtegdjBYadFlEeHsy8e8DH/HcLM
         EHLU/ksokXhFLNKMF8N5L+jFV7EotsyD/kD6EVpo=
Authentication-Results: mxback12j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva7-56e9317134d0.qloud-c.yandex.net with HTTP;
        Fri, 26 Jul 2019 23:40:51 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     Ilya Kantor <iliakan@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com>
         <xmqqtvbaoysd.fsf@gitster-ct.c.googlers.com> <15314A71-8121-428D-A62D-08E1C1AC0E1B@gmail.com>
Subject: Re: [git for translators] How to always generate conflicts for merges?
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 26 Jul 2019 23:40:51 +0300
Message-Id: <318401564173651@iva7-56e9317134d0.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

As I see it, in Junio's approach you more likely to have a translation and original out of sync because you have to figure out whether the changes in the original are actually reflected in the translation, which could be a tedious thing to do again and again.

In the approach that Ilya uses you HAVE TO manually fix just what has changed: you will have a content in the original language in places not yet translated. This approach abuses git a bit and, as I understand, works because all the repos with the translations were probably forked from the original repo so they are NOT unrelated.

As the answer to the original problem I would ask if it really matters whether you have a conflict or not. Just fix conflicts, commit and review all the new stuff that was added in the commits just merged and fix it too. The process is still human-controlled: if you do forget to translate something, it will be left untraslated and is likely to be spotted soon. You want to have a conflict where there ain't one (a new content that does not exist in your translation). A conflict is when something has changed in different wayS since a common ancestor.


25.07.2019, 20:42, "Ilya Kantor" <iliakan@gmail.com>:
> Hi Junio,
>
> There's a repo for each language, with the same file structure.
>
> For example, English version (upstream):
> https://github.com/javascript-tutorial/en.javascript.info/blob/master/1-js/01-getting-started/1-intro/article.md
>
> Japanese:
> https://github.com/javascript-tutorial/ja.javascript.info/blob/master/1-js/01-getting-started/1-intro/article.md
>
> As English version is updated, changes need to be delivered to translations.
> That's done with "git pull upstream master" from translations.
>
> As the text structure (paragraphs) is the same, usually merges give conflicts exactly in the places where English version changed.
>
> Sometimes though, e.g. when a new chapter is added to upstream, the merge just goes through "successfully".
>
> That's what I'd like to avoid, as all changes need to be human-controlled.
>
> ---
> Ilya Kantor
> https://javascript.info
>
>>  On 25 Jul 2019, at 19:37, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  Ilya Kantor <iliakan@gmail.com> writes:
>>
>>>  We're using Git to manage translations of an open-source book, and
>>>  most of time it works well. But there's also a problem.
>>>
>>>  When we pull changes from upstream (English) to translation
>>>  (e.g. Japanese), git auto-merges them.
>>>
>>>  Sometimes there conflicts, but not all the time.
>>>
>>>  For example, when a new file is added to English, it just gets
>>>  auto-merged into Japanese. But all new changes must be
>>>  human-controlled, translated.
>>>
>>>  Is there a way to force git always generate a conflict, even if
>>>  changes could be auto-merged?
>>
>>  I am not sure what the workflow here and if it makes sense. When
>>  you have a file, "chapter47.txt", whose original is in English, the
>>  translation projects (there are N of them, one for each language)
>>  will have their own "chapter47.txt" that has translated text in the
>>  same place? It looks to me that, working that way, the project for
>>  translating into e.g. Japanese have no way to keep any of the
>>  original English version, in which case why are you even "merging"
>>  the English version in the first place?
>>
>>  I would have understood if the original "chapter47.txt" is translated
>>  into "chapter47_ja.txt" and friends, like "chapter47_fr.txt", all of
>>  which sit next to the original "chapter47.txt". Then merging an
>>  updated version of the original from time to time would make perfect
>>  sense to me---that would give you a way to see what changed in the
>>  original (e.g. "git show --first-parent -m -p master chapter47.txt")
>>  to guide you find the places you would need to make corresponding
>>  changes to the variant of your language, e.g. "chapter47_??.txt".


