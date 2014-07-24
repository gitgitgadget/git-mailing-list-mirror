From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] prune --repos: fix uninitialized access
Date: Thu, 24 Jul 2014 17:14:15 +0700
Message-ID: <CACsJy8BHnE83qddHaAJjKEv_J=VvvyMPeDbTmiFXatJeLwwGHw@mail.gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406115795-24082-3-git-send-email-pclouds@gmail.com> <xmqq61inetib.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 12:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAG33-000689-GM
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 12:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934631AbaGXKOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 06:14:49 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:64778 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933437AbaGXKOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 06:14:46 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so2929586qge.39
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4+6d2dY6aOoxZLNj+QldtqlVy58ecFw4ijAPzK4uJjA=;
        b=f5jQG2GePg9kHu1KfPDDn3Qq8GU8jCuhW8UNWL5BSqeNGL6ZKy/IJSB3lzmEujT+VA
         uk5RVHn/JIa426FF34ftKcQIa5ourxoPrjYJ8YMah3ybp1mL35nrHbzew+tQgqyaPtiE
         s/PlPhdjqmxTVtllGB39QPyJfbu6CSpiMsxn1QNuEgKz77LflTTpUGzdosrKhencbnRG
         tBWOLmXu63FFSAMOrFOxc3d8lRHdyB6nINTsPdfQn69mYrsO39YgZNL7GPpMuBz3USYF
         TYanl1TKDlgnmRTeNEJJWkwIPnU2bSNUFFO9dLPwHR1WEKoCoHqr6P7dRzPaUl8yX0L+
         M+tg==
X-Received: by 10.224.122.83 with SMTP id k19mr12816079qar.78.1406196885373;
 Thu, 24 Jul 2014 03:14:45 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 24 Jul 2014 03:14:15 -0700 (PDT)
In-Reply-To: <xmqq61inetib.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254153>

On Thu, Jul 24, 2014 at 2:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It does not explain what the change to the test is about, though.

The old test and code are wrong. We want to verify repos are not
pruned if they're new (like, just created). But "git prune" without
--expire sets expire time to 0xffffffff (everything will be pruned) so
today's repos are pruned as well. But the old code is wrong. It
returns 0 at the end of prune_repo_dir instead of1, so st.st_mtime is
never checked, the repos are not pruned. The end result is an
incorrect passed test :(
-- 
Duy
