Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57641F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFKUW7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:22:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:36973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933494AbeFKUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:22:58 -0400
Received: from localhost ([188.192.2.98]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbaS9-1fjBPR1eyb-00J5Jj; Mon, 11
 Jun 2018 22:22:48 +0200
Date:   Mon, 11 Jun 2018 22:22:47 +0200
From:   Clemens Buchacher <drizzd@gmx.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] checkout files in-place
Message-ID: <20180611202247.GA1236@Sonnenschein.localdomain>
References: <20180610194444.GA1913@Sonnenschein.localdomain>
 <20180611020411.GE38834@genre.crustytoothpaste.net>
 <xmqqvaapb3r1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvaapb3r1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K1:E/4KNZGUe2ZrPKTRcot2BFB1vWv++K1FLa5v+Dybky1e+kWuoVd
 m8xoDXo0IXsJG71bJLt3lz2ijQ5VH5MEUTBN7JHnxOSKiPGywYKt5ssIEmiaynL/SmpSLuX
 sPxNPG4n08HyMcCH+BO7xoCra0gKawHXrd1JHHbzrzJsB3AQK2yN+nhKhwBsm+VoKM+Gys3
 lLVJi30ObmL1layjUzQUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tC871rb5S7Y=:U+LhW8y0ssCrtLB7815Mwh
 S4yEJL3k1/s/2BgIqNyKIluvsWxlOzMEW0/cP6Q1h9ovJFZF2hslSY/j0HhsgvD0gksaxILTn
 glzALSzthqBdW7A8UzoccbhFxZPFzcOegRre1/+Rr5PGMl6tXeRDRtz33akSjRmEZEz2RGKmQ
 lT9CDuJj1upv/VD1zaWpj/+tUD0pfLImlcnsfpcmExwVVOivLWLUA8LI9/I5GvBbY3kOZKLw/
 dYK9dUee5hhSzN0SDZuy3BhdRrcs1jgI9MmfAQ1xUkB+V2AQSe/ZnMnK4wyGnH2NKQG4l5xQD
 OVP36pFJrl7j8ilaKbZe0ZfZ9cOk3QiJIs9ymP+Rxgi3DWeaJYafQyq6HI///WyyDtCJPmD2c
 K8oTvdWGCBy4Luwa/bFW41xvUbbVZguvwucqVnicZMOg6xqxvdlS8G0QFxlwvovQeO9fb8BdD
 w1QZarNYVNI7gVk41F8oDkeVM8FHf3LH0RiKsHwPvOagpnI9E2ygEsU8elVqrtbKJlmspaSvx
 5ztfDp10iz2CDCrwdXYjlwVYIbKC+DRccoWzeEtSE/J6rwGozKmL23c0pCDgVAaMidgZPB+eC
 iMFuJ2uNsOCGpF7qeOuiJJbe1VecuAXk1SySl7FPX+OysML4aqkxqISyA7njMrEV6W+oQrR7K
 ijZfeZpdmBEabBGYENQpUubbHGQxRksQtYUXTBBAT/S3YKl3zUd8a5bQlBRDx9cbXDWl5fkLu
 lDFVFGp5saubFafdV/F9ECSrkwDj5mOl4KukgITVOFr2Bz0H4heK5Nqmjzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 11:02:42AM -0700, Junio C Hamano wrote:
> 
> Aside from us not having to worry about emulating the umask, another
> reason why we prefer "create, complete the write, and then finally
> rename" over "overwrite and let it fail in the middle" is that the
> former makes sure we never leave the path in a bad state.

But the current checkout implementation does not do this. It writes
directly to the target location. The only difference to in-place
checkout is that files are unlinked before they are opened for writing.
