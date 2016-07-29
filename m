Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AAF1F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 08:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbcG2Ix7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 04:53:59 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33104 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbcG2Ix6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 04:53:58 -0400
Received: by mail-vk0-f53.google.com with SMTP id x130so49980653vkc.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 01:53:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=8sO78cc5Ua4f6Omw9P1TZgaAEf/x8OhSsy0jGk3DgM0=;
        b=qyX1p8fy/yKmtiT6v30Qeg+N74LGCupvDv2mB7or8Dikv3bTFk3ngfzSxh5sC+5/Oh
         s/s/nHxbQF94rfigw/U/u3UQlBoGuLySoBnLhw6bfV8tqBm9wE0m4Bd4wStJDVEIBKEs
         MJki76VSe0TH1jWtk90mcQro1OLR8ixQhG2qrxWzd5prWaJctqLrE+1vcYFMkMDbXm76
         lbn0CUt4wej8SZxCbm75KCGF28Nz3BRtdZ+CZoYth6IkbBOzMYEZw57TUdK5qqKCLvEa
         28YL7x5YG497j4h5vYiCY2FUOgHXCEjj0fAJYlTeoOHl+tK7scg90662Cz6KaW9GRE87
         bIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8sO78cc5Ua4f6Omw9P1TZgaAEf/x8OhSsy0jGk3DgM0=;
        b=ZVvSXut/FKO4FCR8PPVe8lvrW2ZOD7S7fZuU4XcIlqRYVpr/QIkOufVwnJjl4J53Ki
         AU+P47HinDVaxggw5EFexMhMOKoZObJy5BJ6Zdc2C5jYmObL3NkMMmZRLK3ZYBZVsLuv
         zyeqPkk6BJD91y2r3TXHEQdM+fVieFQtCOVuGgVj1YDun+plXj7BDs7NEu6ukeaq6r0h
         MNNIvmkkC5a83zY1dH2dV3iCHAmSMqlRXXbk95BQlap51MMG5QzXRObsJIsbLFLdry/E
         4Zp2lzZUklF9zE6U/cUDhT7rixEFp8oakffrsnD5PyexyYvZnPMhEnNT2Agx0hh0GoOA
         wMug==
X-Gm-Message-State: AEkooutpkwI0k4kVxUyvrqpItcyfZsJDsH5dcqZRWohTatLP4rjYjXxA3o5iG2E8HXlg+2Qh/kzEextQMJ512A==
X-Received: by 10.31.82.4 with SMTP id g4mr18198315vkb.77.1469782436706; Fri,
 29 Jul 2016 01:53:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.10.69 with HTTP; Fri, 29 Jul 2016 01:53:56 -0700 (PDT)
From:	Oleg Taranenko <olegtaranenko@gmail.com>
Date:	Fri, 29 Jul 2016 10:53:56 +0200
Message-ID: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
Subject: git bisect for reachable commits only
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi all,


I just found an interesting post how git bisect can trouble humans.
Full story is here
https://groups.google.com/forum/#!topic/git-users/v3__t42qbKE


My suggestion to fix it (ditto)


What I suggest change logic of bisecting to something like


      git config bisect.reachable true


This behaviour will reduce bisecting only to reachable commits between
bad/good points and will never goes away.

Maybe if commit will be found at merge commit git bisect can suggest
open another round trip to looking into not reachable way, but anyway
it should be explicit confirmed by user.


BTW, if bad commit is merge point with more than 2 parents, how git
bisect will find "first wrong commit" at the current state?


Thanks for the attention,


Oleg
