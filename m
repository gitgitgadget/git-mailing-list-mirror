From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid overwrites
Date: Sat, 5 Jan 2013 13:24:19 +0700
Message-ID: <CACsJy8CZe=qyzmG_1vdLYp07OvkDAU4wYc8MN3et7WBVmMhJOQ@mail.gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <CACsJy8BeuV8esGTWsQiT_G9pZE28s5KJxH6+dzdhioLgmSiNVg@mail.gmail.com> <7vk3rsqm6u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael <fedora.dm0@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNC3-0001Pp-1r
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab3AEGYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:24:51 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42930 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3AEGYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:24:50 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so15352812obb.37
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 22:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WaHw1FIL5Heuz1E+n0FN9IsCHr13/KSNurZ93G7eNHk=;
        b=kJ0MpjzQYAZ8m9oy0pLfPSzzC5q8FefQPoMhvCwhJtmiPlLla39Obl8ICFJoA9kM0/
         KuuKWr57zt38zDqJgLYY7+34SmThHtR19AS0pPNtElFy5EjOeQ63+FK4V4OO03QoAgt/
         vpDLhbUEqq135qOeUWmimNlWaE48hsE/9MVzObTAw2ZPVtF8053OGfrKuOVIlzOSG2yP
         TXcKwXvL0ktoZEAjM44x1pNC4bpmBXSwjhDxSaW/Dl/NN3Iz56K2HXhWAIWeCaEbHada
         vVi7VxIdN7pveCWCJxLwh02HY9z3s3pOZoj95ZL3YZZfCnis7t9tS2EM62F4IZ2+V7n7
         QDCg==
Received: by 10.60.154.169 with SMTP id vp9mr30147107oeb.109.1357367089560;
 Fri, 04 Jan 2013 22:24:49 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 4 Jan 2013 22:24:19 -0800 (PST)
In-Reply-To: <7vk3rsqm6u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212663>

On Sat, Jan 5, 2013 at 11:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I personally do not think a wrapper with limited slots is a healthy
> direction to go.  Most places we use getenv() do not let the return
> value live across their scope, and those that do should explicitly
> copy the value away.  It's between validating that there is _no_ *env()
> calls in the codepath between a getenv() call and the use of its
> return value, and validating that there is at most 4 such calls there.
> The former is much easier to verify and maintain, I think.

I did not look carefully and was scared of 143 getenv calls. But with
about 4 calls, yes it's best to do without the wrapper.
-- 
Duy
