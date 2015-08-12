From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Wed, 12 Aug 2015 15:48:25 -0700
Message-ID: <xmqqio8kjf7q.fsf@gitster.dls.corp.google.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	<1439416645-19173-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, chriscool@tuxfamily.org,
	pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPeox-0000YX-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbbHLWs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:48:27 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35741 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbHLWs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:48:26 -0400
Received: by pdrg1 with SMTP id g1so11899446pdr.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bGDQK6/IdSg6Im0vYyN/OisqYbrJ1o+1JkKpbqvtI4Q=;
        b=ZoT3bEejHxGWdqDWG5tFbz/7t1GRcbApreAOES8QtZR6OZs7+mXeKGbUcJmOCpdBI0
         OyaXLhtVLty1mrHLP8IfYY58wA0mWf9VU65oruT59ibt1N9vRnckzHo12bKSnGp0boSs
         M9w8rEwXeCufoRUV2caIlAJdsOQtTCdNLyfLyxGjhETM/qtX9BEEWqNofqobZjd4mrpT
         j0xVXyrN8D1o+37tV3JSlwwW1zT8oG56C+Ll5+YIpQQWRWAsAp1Kr+6hmHvDmk61tZnQ
         dpXXhuvJbzPSbpdp3eS+oE3Ze9iHK7BbH6MHd3UiJCHgaCDOKUg37bDOv/ly2uL+Un+H
         +bIA==
X-Received: by 10.70.8.97 with SMTP id q1mr71748625pda.31.1439419706299;
        Wed, 12 Aug 2015 15:48:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id ip7sm173697pbc.68.2015.08.12.15.48.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 15:48:25 -0700 (PDT)
In-Reply-To: <1439416645-19173-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 12 Aug 2015 17:57:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275825>

David Turner <dturner@twopensource.com> writes:

> Instead of a linear search over common_list to check whether
> a path is common, use a trie.  The trie search operates on
> path prefixes, and handles excludes.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>
> Probably overkill, but maybe we could later use it for making exclude
> or sparse-checkout matching faster (or maybe we have to go all the way
> to McNaughton-Yamada for that to be truly worthwhile).

This is why I love this list.  A mere mention of "something better
than linear list" immediately is answered by a trie and a mention of
McNaughton-Yamada ;-).
