From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Make git-update-ref invoke the update and post-update hooks
Date: Mon, 15 Jun 2015 14:45:55 -0700
Message-ID: <xmqqd20w7ii4.fsf@gitster.dls.corp.google.com>
References: <CAEJ-0i-BB=5W-Ah3nkeLFCe5-4XW4CvYaDgdqv1mMp4UGF81qw@mail.gmail.com>
	<xmqqpp4w7mco.fsf@gitster.dls.corp.google.com>
	<CAEJ-0i8mfabWoLivX_ZJHRJBYFftoENWmHw5__CGphK54oOpug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Brian Vandenberg <phantall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4cCh-0005xl-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 23:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbbFOVp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 17:45:59 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38059 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbbFOVp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 17:45:57 -0400
Received: by igblz2 with SMTP id lz2so1208957igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EAAHAA843ey3V6ZtxIuRGniUaaygyxclpwKIDKeU0io=;
        b=fB63M+uUkBO6KRI5mn6Un8Bq3x5YUpn14C95UQR6EoZ6x9pMddT3O+BNL7qO/vrT9D
         LtDPsfsNuGg1anqRC3boCeaS+lNSI7TtOVc0U9rb5+WGvABYWYr9KE8Sk11xf0qY9g8h
         tITPoXdkEAvdyQoeamuEH92yCbC+52HtY05baXg+LEG/3Skwk8XAEzkRy8Ux93ezyH8m
         YmTCH+VeSPih4KSnXjwSRbVAVHw5j/oXlHldW8VRzoIyDEpQ4D1lwfpoJPPG2+gHCBXv
         qwEOiOSHkJdkagY6lTNNomyYp1YdZ8+4KA+LmZE3T+1OWsUVT5tK6dA8RKv4N5MxfqKh
         SxGw==
X-Received: by 10.50.79.202 with SMTP id l10mr23821655igx.7.1434404757254;
        Mon, 15 Jun 2015 14:45:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id eg3sm8496154igb.0.2015.06.15.14.45.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 14:45:56 -0700 (PDT)
In-Reply-To: <CAEJ-0i8mfabWoLivX_ZJHRJBYFftoENWmHw5__CGphK54oOpug@mail.gmail.com>
	(Brian Vandenberg's message of "Mon, 15 Jun 2015 14:58:35 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271735>

Brian Vandenberg <phantall@gmail.com> writes:

> Would you be less doubtful about adding a lower-level hook for
> update-ref?  Or in lieu of that, a config option that can affect the
> behavior of its "-m" and "-d" options?

Not really.

Those who want to bypass your policy can use "vi .git/packed-refs"
and/or "rm .git/refs/heads/foo"; you would not propose to patch "rm"
and "vi" to pay attention to git configuration, because they are not
about "git" at all, and there are cases where these bare-metal level
editing of repositories is necessary.  You would instead tell them
"don't do that".

When I say "update-ref is a low-level plumbing command that should
not enforce policy", I am suggesting you to treat the command just
like you would treat "rm" and "vi".
