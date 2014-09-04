From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v3 20/21] signed push: add "pushee" header to push certificate
Date: Thu, 4 Sep 2014 14:13:57 -0700
Message-ID: <CAJo=hJsd8wfqvxBMThwh76BqTD9eZza98PRKOfgtr=-eQkUh3A@mail.gmail.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com> <1409861097-19151-21-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:14:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPeMM-0004LL-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbaIDVOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:14:21 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46895 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbaIDVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 17:14:18 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so24696iec.22
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2592o0s1jVP0Fu5OXONeICR38lbkY3/2QBrUltJZ6W0=;
        b=RHI9Jt4If/ciSFST67g+Sauw5hGF88JKm1EG2FWiRnt0RtRfTxVjU6U42cvMhxIRgA
         kIWMoTY9QKYnTnJlNDSxggt/B3uu6fCNjAuW2E9cMQoK+nAaWVhYZqFBxhnlH+4WRcMy
         UShcSNQ85I7zlxyJahN063p48cSe4aKawuuQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2592o0s1jVP0Fu5OXONeICR38lbkY3/2QBrUltJZ6W0=;
        b=XF7MKRy3YYwF6th+BFgcOBFjgpj2MQdKI+HYDaGe5hX2OcxtWw7Q1PRIifxCtPg05v
         3fJMiOSruvCxyAbjeqwAkWn65IjiK+dyAVXhJ6/bcAAxbZioCjta7hOcRWDw+3fBP+E6
         3/wnN8BLXBW44RqEo9mA8HEh8VyL/FXZgfAw9YJyehDZy55Zj5mDTTwKuntlWvz6PvBn
         /EB8z/8LBdTAADeBb0pr7cKzZyTM7ceN/WEuoOohcDA0gL/K61MPSdYw0BwbF7Ifpw76
         AzdOamK5/uei77mvEJBCo95N2jT2Vbdn6jH6NHK8ZBao38tORRcMJmxlJoQ86BM0f/P9
         bA5Q==
X-Gm-Message-State: ALoCoQk0lLaAN+TNHaPv2JKTInfiz8+tqIOCaUdj7ttLx3sDyNfkXNFnB1TcqhMjvf7gKOyhoBPW
X-Received: by 10.42.109.79 with SMTP id k15mr9660824icp.42.1409865257997;
 Thu, 04 Sep 2014 14:14:17 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Thu, 4 Sep 2014 14:13:57 -0700 (PDT)
In-Reply-To: <1409861097-19151-21-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256482>

On Thu, Sep 4, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Record the URL of the intended recipient for a push (after
> anonymizing it if it has authentication material) on a new "pushee
> URL" header.  Because the networking configuration (SSH-tunnels,
> proxies, etc.) on the pushing user's side varies, the receiving
> repository may not know the single canonical URL all the pushing
> users would refer it as (besides, many sites allow pushing over
> ssh://host/path and https://host/path protocols to the same
> repository but with different local part of the path).  So this
> value may not be reliably used for replay-attack prevention
> purposes, but this will still serve as a human readable hint to
> identify the repository the certificate refers to.

Well, a push cert validator could require the pushee use specific
URL(s) known to it. The server operator knows their URL space and
could just demand that users use ssh://host/path and https://host/path
and nothing fancy like aliases in ~/.ssh/config.

But I think you are right to punt on that and let the cert validator
hook written by the server operator to decide if pushee should be
verified.
