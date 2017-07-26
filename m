Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450DF1F89D
	for <e@80x24.org>; Wed, 26 Jul 2017 00:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdGZAVY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 20:21:24 -0400
Received: from smtp40.i.mail.ru ([94.100.177.100]:45184 "EHLO smtp40.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdGZAVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 20:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=mnp38pRXOAi75mJb7XBKLx+bMor16Ay668I13+tIj6Y=;
        b=oNCXe90liRX1NaSzY76Vr03R8uAjZ/W3eRd6Lv3o8NtoQA6wd04jTxjK5kInFo6LNjr51WtKXQhb2FtduKIyen54u5tTWjqq5jdf1xnf3g+/JatUbGzIqUu3NrBFZlNOD/QFHGIcNDVFiveg/00B1s6pvqzCtm22qyei3+wnvJ8=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1daA4m-00061i-96; Wed, 26 Jul 2017 03:21:20 +0300
Subject: Re: git gc seems to break --symbolic-full-name
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
 <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
 <CA+P7+xrpKTuBTueyGGVz4doWMnbGQo+2qj2wbpPvXBaW-iDV2w@mail.gmail.com>
From:   Stas Sergeev <stsp@list.ru>
Message-ID: <60331e4f-93a7-5ceb-1443-41212b9fb945@list.ru>
Date:   Wed, 26 Jul 2017 03:21:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrpKTuBTueyGGVz4doWMnbGQo+2qj2wbpPvXBaW-iDV2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
Authentication-Results: smtp40.i.mail.ru; auth=pass smtp.auth=stsp@list.ru smtp.mailfrom=stsp@list.ru
X-7FA49CB5: 0D63561A33F958A53708C766CA3419D79DCCD0DB222E26931F42DF47398C4A6D725E5C173C3A84C3C9EEE74C166EF7BCCF00CBA460D8C00F89C8E7BF4648B176C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FD29CFF114C3378C93B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C4229833AEAB720B0CBF5FB1BAB58DE5A3CDBF1189B093656B61653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

24.07.2017 07:02, Jacob Keller пишет:
> generally, I'd suggest using "git describe" to output a version based
> on tag, and as part of your build system set that in some sort of
> --version output of some kind.
I came to the following solution which
looks quite simple (avoids comparing the
output of git describe):
git log -1 --format=%cd --date=rfc | xargs -I {} touch --date={} $TSTAMP

The care must be taken to put the timestamp
file as a pre-requisite of the .LOW_RESOLUTION_TIME
target, and the build seems to work properly.
This still smells hackish, but this time I blame
make for an inability to specify the timestamps
explicitly. :)
