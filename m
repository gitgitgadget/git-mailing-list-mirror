From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Fri, 13 Feb 2015 10:32:06 -0800
Message-ID: <CAGZ79kYRi3KYcvNQbkhP0uLFgpJzD+h=P+smOLQy2Msv0C_1kw@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>
	<xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:32:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YML2J-00004u-03
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 19:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbBMScJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 13:32:09 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:59514 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbbBMScI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 13:32:08 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so12334256igd.4
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ca9oTWANV4MvQr3ssfXkVFljFsAgbrcvAcBpASMonN4=;
        b=Jslu2/ttH/om6ldDPlEBZXFCxIRH+h+neCVHNA8A7xHzar44tw8KOZHkM34TjLpZfw
         48pCVIWKluNCQfjkHWm/MqRlqzxmuxVG6zjNDDIAOp7oJF5xRNv0BjMWMz2KWOEG8TJI
         SB0FRRgEY/vA9jUAJzwv0h/GR/svH4v+gjvzxLiM2GWCs+LpyzMEBvy2uuiugGSImceT
         M6srPD1Wrt7nft7ODVKR/pDIgPc/2LZ98ZQQ/xtWzt21J9wOFrAx9DAoz4AkmCVFY5yk
         jlobCf7zfdhdVUneo4wmXNBn2tjwGMKHoYTlnpYGjPaJ8cE6iJ+Xq/HoFTDx4H3nAAJl
         oung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ca9oTWANV4MvQr3ssfXkVFljFsAgbrcvAcBpASMonN4=;
        b=WEAX95lDPPeH72bII2Un2h4SRLCHJncWQqrf7gyJbzhHBQL8WSYwu1b6iOS4kTbM5N
         QX6Rw+PhyDbeq9QB3FFNNOJaigWbtrpCDfc7ge0aeCP/MCHjCCeJnAQhBvgcMrCxGeTJ
         4S8JEqkMEnV7hOAbXEA0kD2L2saTk0FZcZSd5zs6OG6AoLEQcD8wOyluDoOziJRgqzvz
         yw0JqxNiLTTH03Yzs5dS36jpb2zcj6hRBt/4EhgReR3JqDyLiqkVuQrebuSVYRWlnwW/
         rNMu4HxN9AyJno4LkFwDduMUXPyOcQ8QrdTFOh/Enwq1i4MCZdmc66QLULX2FyWxc98L
         3nfQ==
X-Gm-Message-State: ALoCoQn2M9nH/zZmRuep7p9MxSYOI1dTfIed9qZi4/vKePJgyx+UOYPtH2KxzlndxnP2OL/muJma
X-Received: by 10.50.128.38 with SMTP id nl6mr5541360igb.48.1423852326637;
 Fri, 13 Feb 2015 10:32:06 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 13 Feb 2015 10:32:06 -0800 (PST)
In-Reply-To: <xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263820>

On Fri, Feb 13, 2015 at 10:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Feb 13, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> We convinced ourselves that not locking the symref is wrong, but
>>> have we actually convinced us that not locking the underlying ref,
>>> as long as we have a lock on the symref, is safe?
>>>
>>> To protect you, the holder of a lock on refs/remotes/origin/HEAD
>>> that happens to point at refs/remotes/origin/next, from somebody who
>>> is updating the underlying refs/remotes/origin/next directly without
>>> going through the symbolic ref (e.g. receive-pack), wouldn't the
>>> other party need to find any and all symbolic refs that point at the
>>> underlying ref and take locks on them?
>>
>> As we're just modifying the ref log of HEAD in this case, we don't bother
>> with where the HEAD points to. The other party may change
>> refs/remotes/origin/next without us noticing, but we don't care here as
>> all we do is rewriting the ref log for HEAD.
>>
>> If the other party were to modify HEAD (point it to some other branch, or
>> forward the branch pointed to), they'd be expected to lock HEAD and
>> would fail as we have the lock?
>
> I was not talking about HEAD in what you are responding to, though.
> Don't we maintain a reflog on refs/remotes/origin/HEAD?  Is it OK to
> allow its entries to become inconsistent with the underlying ref?
>

Yes we do have a HEAD ref log, and that ref log would differ from
the underlying ref log. I don't know if that is desired, but I would tend to
not like it.

So the other party updating the underlying ref would also need to lock
HEAD then,
which ... they don't. But they try writing to it nevertheless, in
refs.c line 3121-3150
see the /* special hack */ comment.
