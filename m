From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Thu, 24 Jan 2013 12:51:40 +0700
Message-ID: <CACsJy8CtV-ngy4iGm3Vn3bu9XwpSrZ_AeWpPxTC2TY_qXv=Cxw@mail.gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com> <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
 <7v1udcn84w.fsf@alter.siamese.dyndns.org> <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com>
 <7vwqv3dw2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 06:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyFjl-00050B-2c
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 06:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab3AXFwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 00:52:13 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:40574 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3AXFwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 00:52:11 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so9211816oag.7
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 21:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UaMBbpCtpNamLlGIzzLA8gUM5pJUnFw1pLrtoKQcLds=;
        b=Bs4/Ln6H5MAb3BA+9aoD+OhCqjqmPFp9CVCqvjXc/TfMUy5XSzAp/TT2u7U6iVLnRS
         51Fbbw1FVlew168kqbp/RQ+L6dqy3yNa+31DPU587LHS8geHlG0XUJkyKzGhXKtE4XF+
         mLm3AIQBd+u5QNRkk5l7oGp+UEKnvbhTgji0dfJLnRzudoUY7YxoAmNiBe3NJbgqxGjZ
         TTF5rs6QNy/kOMoPhrlrxfcQIIIGLGM9obonlg1dOOQ+xBqu6O0X9adWfdJId8k0tCbc
         lB3B0jTkOBcsERwuZXSYrV3RRTKVYKG8zjofCG0MKRKnH2Aiqkga2I0VDiAaxROZfpdK
         gwcA==
X-Received: by 10.60.32.44 with SMTP id f12mr596778oei.61.1359006730667; Wed,
 23 Jan 2013 21:52:10 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 21:51:40 -0800 (PST)
In-Reply-To: <7vwqv3dw2n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214394>

On Thu, Jan 24, 2013 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The only problem I see is, without the version string, there's no way
>> to know if "**" is supported. Old git versions will happily take "**"
>> and interpret as "*". When you advise someone to use "**" you might
>> need to add "check if you have this version of git". This problem does
>> not exist with pathspec magic like :(glob)
>
> OK, so what do we want to do when we do the real "USE_WILDMATCH"
> that is not the current experimental curiosity?  Use ":(wild)" or
> something?

I don't think we need to support two different sets of wildcards in
the long run. I'm thinking of adding ":(glob)" with WM_PATHNAME.
Pathspec without :(glob) still uses the current wildcards (i.e. no
FNM_PATHNAME). At some point, like 2.0, we either switch the behavior
of patterns-without-:(glob) to WM_PATHNAME, or just disable wildcards
when :(glob) is not present.
-- 
Duy
