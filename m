Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53CC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 14:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiHLOAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHLOAv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 10:00:51 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 07:00:50 PDT
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBD82FAD
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 07:00:50 -0700 (PDT)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 4M44p10RQ4z4Cyc
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:51:05 +0000 (UTC)
        (envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4M44p06pYzz3jQw
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:51:04 +0000 (UTC)
        (envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
        t=1660312265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SKF3LK9q7asbflyJImwBAS8MYakucBooGgm7g6nUM0Q=;
        b=qfh47H3ZURxxLOAAR7OaGeQ/Iw2rQtn/0sTIQSeHNlGTxh7554MpYGe3HoJMJ9DaxoJRZe
        dGexQA2mVAgiZtBTffcgfFrLuJ6yG56f3aUwzGQ02qg4jA3pk53Nf+/Td5h90rnAdScQ2r
        Iv8y6aeylmPHXdUbqjE3LB+4f1/SRJ4mygi2Sv7JOjLKAeCARyVHtl2Us1IlOcMhgTVrOF
        zCbtH65gx48L8q0BewUrA5bfkjtsSgyQrltkXkzxLz+eJY1v64IDUZ/KT1QIYSMvwfR0bx
        KY7g64dcPS4hvEtvkvMs1bOJ5RaQH9rZzQpLLoGi5ncthFKazPVel2Gc+naJcA==
Received: from [172.21.4.170] (dynamic-177-53-82-16.telecominternet.net.br [177.53.82.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        (Authenticated sender: garga)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 4M44p047KTz1Jgk
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:51:04 +0000 (UTC)
        (envelope-from garga@FreeBSD.org)
Message-ID: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
Date:   Fri, 12 Aug 2022 10:51:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Language: en-US
From:   Renato Botelho <garga@FreeBSD.org>
Subject: git maintenance broken on FreeBSD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
        s=dkim; t=1660312265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SKF3LK9q7asbflyJImwBAS8MYakucBooGgm7g6nUM0Q=;
        b=PKxWzKBsoBvzdc3ajb56fgn5QZ1CQO6/wdZIrvAouKu5o0oazUv+/SwQU+xgoLju2ETelB
        2ruiCVM1gNA2LErAhF323av+Nne76oKCtPU3FWEc0QZ5xJcE9A51n/rXInvgM5hXHxOaxo
        TLGUs8eF9L3JTVr/DRb7CiZAlrsrGmgNppavKsJE4QLcCyw2yrja6YDg6ytQh/FeFc75jt
        SlUf1jqic3F0y0whyEQ0SGW/WX7syZyOjC/YWhB1g+UsNgwtkN/Di8suj6jEdu3blvis00
        t0VgdHlNWn010VihR5Agvtvx8hKbBF1eNY3bhISunYyQUT45b8dt5zHI6YjAfQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1660312265; a=rsa-sha256; cv=none;
        b=B7qLrW6xoAcY36BT6FFiGBA8/L3vKo8IuT+Xsg6LsNXiAIn7ZNUcMK7p2V/0NF1tAQV7iV
        wFyG5J3YYI6/6WpffkdV62S2B0e84ZRNqhl2Z2MhlPVtx2KkYT+HBcaDE+zMqHrRQzje9J
        By56wqrReyn2hssnZj+bHqJ3+HUrSNZYZGG2Lb7I5vXd9DLJ+vMSwI/IQn21Xhwtk+1gla
        FyAckCGsIBvYegq9YvatrXQYF2BpxtyyjmHH/3jlJMJyrId6gny+rkPfmZnAmENbiNwAK7
        lmHXxoG3bBhSYD3PAoUpws9cZ8Mxyipn8BZpgnFGyn4wuU5YQ2h9nEAK4DKihA==
ARC-Authentication-Results: i=1;
        mx1.freebsd.org;
        none
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported at [1], git maintenance is not working on FreeBSD.  I didn't 
find the time to dig into it but it seems like it's calling crontab 
using parameters not supported on FreeBSD.

[1] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=260746
-- 
Renato Botelho
