Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463FA1F42D
	for <e@80x24.org>; Fri, 18 May 2018 09:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeERJK3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 05:10:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33745 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbeERIT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 04:19:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so2515175wmc.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wjdFq3VT2qEq2unEFeC0CE7GXu3qNd54uDR5vO2f018=;
        b=htmedBMt72X0Hgro7oisEc/wU/hZAo+zTxn/47JLm9Z9f8YzysWV5k1fdAbxIAe4oZ
         g9N18ahb5I/eeM3r2hkeJW9qlY35jjMYsUsYgpidcnF3FHIbPfK8u/72F3+fmKTGNMIx
         VCaFvkw/ZDt9rZFMUiqs47g9VHbSuuI+CBDsbpllyf/oF10WHcia+LTFrqu/Avtg0m9j
         OYY9N+uz8ZJpjztbOeNki1GcSybvDI/i6tVUSAB0wbixJNe8UHgbJuffSbx+m3gKP8cA
         DOFP7JCYszokEToLOL+GibXTYok4Bhwa+MuRHlOYIvaBVMUixs55VHQI2Qclr6BvpnEW
         6yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wjdFq3VT2qEq2unEFeC0CE7GXu3qNd54uDR5vO2f018=;
        b=Yyc5WwopwO1aaCXk+uJSyvBCos0DhF3G+rGIHBY/LWKVdIXvzGUhhbmn1LJaF43AfN
         ACrbFH/7pyFopwJizmGBxrpjhoiABt1ofsimfoMY4UJgKSoQAWSEXSLzzYi8cEADDkVx
         7pi1j2r3W8Pbv3/9s9F3cpUW3SDW64w6oUT+GMIVgOACCd/4KowB/Vcgpgt0mEI6wOLk
         5tQnci+j4FOlvzyI2NB+pgP2oVmSj5GtGWeYymfS9meCzB6BkZEtb6N8et0qDBWHYLVu
         ZrGKrA5ytBtaRwWYArlT3eiS4Y5RQ7tvyrg1/F0DGKPHfrg2l0hqSJA568o24Ipkbl0K
         fHuw==
X-Gm-Message-State: ALKqPwdH6y6ovrH08K2cukBUFyeJ4ntmZReYXrEgl5nxPGzWFA2gFqyo
        I2kPcne8rJZ4MPA2POLOm7TN3hJvLBe7mfAhPgLI2Q==
X-Google-Smtp-Source: AB8JxZo9fj9zeZZbz1SnxOH267HbONljTODTwU/f4PV5AKgTLILE2r9FjK0LUk8Am3DF/PBCyH0ACoMuUkirYXrlU+4=
X-Received: by 2002:a1c:e64e:: with SMTP id d75-v6mr3743156wmh.101.1526631564614;
 Fri, 18 May 2018 01:19:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.93.65.202 with HTTP; Fri, 18 May 2018 01:19:24 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 18 May 2018 11:19:24 +0300
Message-ID: <CAL21Bmncoc0byRWdOdk89fza4y8Lo0HbNp-gsMEFRigGGEwD2Q@mail.gmail.com>
Subject: [PATCH RFC v2 0/4] ref-filter: start using oid_object_info
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
Discussion starts here: [1], [2].

Updates:

I fixed memory leaks, now we use data from oid_object_info() OR from
grab_commom_values() - not both as it was before.

I added support for "%(objectsize:disk)" atom (with tests) and for
"%(deltabase)" atom (without tests yet).
I didn't support "%(*objectsize:disk)" and "%(*deltabase)" because I
can't see the possibility to fill these fields at the same time with
other processes.
I really want to discuss this moment with someone. The best idea that
I have is to fully change grab_common_values() function so that it
would collect and fill all info from oid_object_info_extended(), and
we will invoke it before we actually get and parse full object.

I am not sure with this proposed solution at all: we would still have
the scenario when we call both oid_object_info_extended() and
get_object(), it means the performance will be worse in some cases. I
don't know if it's crucial.

By the way, do we have an official way to measure performance?

I didn't add tests for %(deltabase) atom because I am not sure that it
has sense for for-each-ref at all: I have a guess that I added this
atom only for future using in cat-file command, and also for deref
option %(*deltabase).

I was also thinking about adding new parameter to atom, something like
enum "need oid_object_info", "need get_object" etc, so that we could
collect all needed data in a shortest way. The problem is that the
code will be even more complicated, and I am not sure our goal worth
it. And, anyway, there would be the scenario when we have to call both
oid_object_info_extended() and get_object(): for example, if we have
format="%(objectsize:disk) %(author)".

Thanks a lot,
Waiting for any ideas/comments!

[1] https://public-inbox.org/git/CAL21Bm=6Z54-zsUq0DJqmqhSciHCDLUNXR8inDMAd-b-=QJjcA@mail.gmail.com/
[2] https://public-inbox.org/git/xmqq8t8la81a.fsf@gitster-ct.c.googlers.com/
