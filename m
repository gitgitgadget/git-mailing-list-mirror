From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR
Date: Fri, 26 Jun 2015 12:02:42 -0700
Message-ID: <xmqqk2uqthrh.fsf@gitster.dls.corp.google.com>
References: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
	<1435315055-27011-1-git-send-email-pclouds@gmail.com>
	<xmqqpp4iv1au.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:02:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Ytm-0005v8-D2
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 21:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbbFZTCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 15:02:46 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33520 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbbFZTCp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 15:02:45 -0400
Received: by ieqy10 with SMTP id y10so81766125ieq.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lC82cJxDgj0FTgDHwVsZUn+M/Ri2pOfKEwR7eMnCpLc=;
        b=OvNA9u9tjNnOOD8T8rpN0V3PG8Ldve+7lMuYYMzHaM4UWyiHpYqZOAHqzlo2zNPlIn
         pBC1kDPes/MAbVe/9cmGgcd2nAyefBYDq05FWrW9vU70tnSi+NBZvMbQhob4rV/wJS5B
         eaPqlna/tBpNl3xkqJqCDiwg2/aivBtnN+WWLxP2sdNi/R5DuDYPyFFlcWhg2SsTydId
         LEvsQhGOMnxmPq17xY0CnvrMin/PNiff1rOEJ4YdzxFiJJhUMEJWEK22l3CS9EJIb0sl
         zSPG5z0s1C7kyMWmuOSake5Ae8pYSu1RpfFBQ+QnM3TeXElQz3/FLMcHmquaDP4AFDaa
         MFzA==
X-Received: by 10.50.147.10 with SMTP id tg10mr5604095igb.36.1435345364921;
        Fri, 26 Jun 2015 12:02:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id fm3sm106205igb.1.2015.06.26.12.02.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 12:02:44 -0700 (PDT)
In-Reply-To: <xmqqpp4iv1au.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Jun 2015 10:15:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272813>

Junio C Hamano <gitster@pobox.com> writes:

> But I am not sure if it is true for our children (e.g. hooks,
> filters etc. that is spawned by us).  With this change, they inherit
> GIT_WORK_TREE and no GIT_DIR, in such a case.  If they set GIT_DIR
> themselves for their own use, perhaps arranging to work in somewhere
> else they know by chdir'ing there, they did not have to set
> GIT_WORK_TREE=. before runing git in there, but now they do, because
> we start exporting GIT_WORK_TREE to interfere what they have been
> doing.
>
> "It does not harm" is probably false for our children, I would
> think.  The children can do new things to avoid the harm, though.

Actually, I think I am overly and unnecessarily worried in the
above.

We do not do anything special wrt existing GIT_ environment
variables the user exported into us when spawning hooks or filters;
if existing scripts wanted to visit a different repository and
interact with it while they do their work, they would have already
been seeing these variables in their environment inherited from us,
and they should have been protecting themselves from these settings
anyway.  So I do not think this patch breaks anything (other than
such scripts that are already broken).

So, sorry for a false alarm.  Queued.
