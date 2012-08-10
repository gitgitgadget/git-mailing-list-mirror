From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Fri, 10 Aug 2012 09:23:07 +0700
Message-ID: <CACsJy8ChnS4cE3YnQQA8YQ5ebCA06QBXxEB7Oqhv4z_1y9Wc8w@mail.gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com> <7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
 <7v7gt7mwo3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 04:23:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szet8-0001Ho-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 04:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307Ab2HJCXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 22:23:40 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36025 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759047Ab2HJCXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 22:23:39 -0400
Received: by qcro28 with SMTP id o28so717154qcr.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 19:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o83+CVcZzm9ONBntJqokEeAw8mzkYafB3jXy3xRAx+4=;
        b=EYUdHuuTZvNT3/BgOVo1jWWdPhQkbsBZRAANL+CelqLvLbobCRuL2n6K2ccK7qtS0w
         lFHeCc2Uk1vLVS4Tg2YfZRIJUoFY7mKMho71vTtygddUn2Rt5QoAKQEA2ZzhPbasvPUO
         WcCKRzAaEkYSVt+f812JzKTXQTKuyboWxoCJIHqGWVx0BppqCzW7nFAgfTfR4ZEf7NOI
         Zzys+bcDyfwkAJ4ZL1KiqLW67i5d61zbOJ5IQTXvMjqqgmKWj9Bil3HwQwpSfTU/jXx0
         a/JI80wzp7UpN585JxqWUPfhrj3X7OHUtDl9hX9eaK/vNJ+TwKSgmxRAx8o587riGUo2
         +bWQ==
Received: by 10.229.135.70 with SMTP id m6mr721461qct.104.1344565418717; Thu,
 09 Aug 2012 19:23:38 -0700 (PDT)
Received: by 10.49.84.73 with HTTP; Thu, 9 Aug 2012 19:23:07 -0700 (PDT)
In-Reply-To: <7v7gt7mwo3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203199>

On Fri, Aug 10, 2012 at 7:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, you can only detect such inconsistency when you are
> lucky enough that you catch the other person in the middle of
> writing.
>
> If the index you are looking at holds a large tree with very many
> paths, it is possible that there are two large directories, and
> after you read all entries from one, the other process starts
> modifying the paths in that directory, without you ever finding it
> out.  If the goal of the topic is to make the index work better in
> projects with large trees, it may be wise to think about locking the
> whole thing, so that you do not have to rely on the per-entry crc
> and you being lucky to detect such a race.  The per-entry crc, as
> far as I understand, may have been introduced primarily to detect
> on-disk data corruption; it is not a suitable mechanism to detect
> conflicting accesses.

So we acquire the lock just before we need to write, or at the time we
open for reading?
-- 
Duy
