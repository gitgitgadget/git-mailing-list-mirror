From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 12:48:21 -0700
Message-ID: <xmqqk2w473i2.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
	<xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
	<xmqqd21w8mal.fsf@gitster.dls.corp.google.com>
	<xmqq1tic8lgj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 21:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YunV5-0003bT-NE
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbbESTsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:48:23 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35397 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbESTsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:48:23 -0400
Received: by igbyr2 with SMTP id yr2so85075271igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=957JyXubytLr3hJsKkvG0tDwvEDckULhsBIqIfCMOLI=;
        b=pUy4wHrGTgxv+e/A5q6E447KkqTGBoUTGABuzjWHwJikBYrQPR/dNHdQOraMrpRDRA
         Mdd4tI2ObvDTPLeyPyC2KGfO2yUwSelGkAotnF49GYvRvr5Af1YlE/SPqwH/knz/2qb4
         GZrqqeNsszOWo62/Dz7FsNI2dBpJJzyJHXDVe/DnF21Qsh/p1lNxEeIubim8ojIUjPwm
         /Jr/8SOmugsVOKH+k5Kdwi/yLXL9DwveifWp//zlAxihv04Yd5OuMTG+P2WKxRWqe7ba
         id1XGOfLEoGCNcEQzqWrnXYVtJ2tfkAOa561UbXBIzQCMXBj2k8jxfXr/g02NbOcSpDx
         v5KA==
X-Received: by 10.42.35.139 with SMTP id q11mr23753681icd.88.1432064902469;
        Tue, 19 May 2015 12:48:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id l30sm10675329iod.12.2015.05.19.12.48.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 12:48:21 -0700 (PDT)
In-Reply-To: <xmqq1tic8lgj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 May 2015 11:35:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269395>

Junio C Hamano <gitster@pobox.com> writes:

> Yuck; please discard the previous one.  write_in_full() side is also
> writing into that process, so we should do the same.

OK, without these two, and with the "true" filter that does not read
anything reinstated in the test script, t0021 used to die

    i=0; while sh t0021-conversion.sh; do i=$(( $i + 1 )); done

after 150 iteration or so for me.  With these two, it seems to go on
without breaking (I bored after 1000 iterations), so I'd declare it
good enough ;-)
