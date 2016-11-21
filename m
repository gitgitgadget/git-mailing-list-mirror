Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BDF1FBB0
	for <e@80x24.org>; Mon, 21 Nov 2016 08:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbcKUISx (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 03:18:53 -0500
Received: from forward20o.cmail.yandex.net ([37.9.109.219]:32877 "EHLO
        forward20o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753225AbcKUISw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Nov 2016 03:18:52 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Nov 2016 03:18:52 EST
Received: from mxback4h.mail.yandex.net (mxback4h.mail.yandex.net [84.201.187.141])
        by forward20o.cmail.yandex.net (Yandex) with ESMTP id D0BB0216A0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 11:11:27 +0300 (MSK)
Received: from web21h.yandex.ru (web21h.yandex.ru [84.201.187.155])
        by mxback4h.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 5kwePqTtQA-BON4Puvb;
        Mon, 21 Nov 2016 11:11:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1479715884;
        bh=0bWT+v/MMgsj1mCjxU4NTbOnzCUYJchCSWKb6KogoC8=;
        h=From:To:Subject:Message-Id:Date;
        b=vraFbp2FGzJWKkGw8HzpeHI936uXeoUsKAnnGqSKLFDADGQIKjw+iUDWdVfZj4P9I
         wtVUJvemGDzUMUekeEiLEYdK+Ma+xIS+Lm8ud6c5nkCLIKZrgLvS3WccSyyScUCQGy
         BBkr1aZHQAFh5doVmKojD1TFHvs1beUL5XOPvYXo=
Authentication-Results: mxback4h.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web21h.yandex.ru with HTTP;
        Mon, 21 Nov 2016 11:11:24 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: Feature request: Improve diff algorithm
MIME-Version: 1.0
Message-Id: <14657461479715884@web21h.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 21 Nov 2016 10:11:24 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I have some question about how diff works then give proposal:

it will be very useful for each "symbol" store additional meta info as source line length. So in this case when git counter two equal sequence of commands it will do further comparison: Adds 23 chars deletes none VS adds 75 chars deletes 46

Actually I got this:

@@ -129,8 +132,9 @@ sub _preprocess_message {
 sub _process_message {
     my ($self, $message) = @_;

-    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
+    my $time =  [ gettimeofday ];

+    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
     return $self->send_error(ERROR_REQUEST_INVALID)
         unless defined($method);

Instead of expected:
@@ -129,6 +132,8 @@ sub _preprocess_message {
 sub _process_message {
     my ($self, $message) = @_;

+    my $time =  [ gettimeofday ];
+
     my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
-     
     return $self->send_error(ERROR_REQUEST_INVALID)


Details: http://stackoverflow.com/questions/40550751/unexpected-result-in-git-diff/40552165?noredirect=1#comment68648377_40552165
