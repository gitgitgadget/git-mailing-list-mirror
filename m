From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-objects: convert to use parse_options()
Date: Wed, 1 Feb 2012 21:30:02 +0700
Message-ID: <CACsJy8CZm96pVkavq_LvpX-MxdOtBw7XuwsQF61FJE8qk6ZZTg@mail.gmail.com>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com> <7v4nvb78om.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 15:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsbCr-0000f4-Fr
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 15:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2BAOae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 09:30:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51941 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab2BAOad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 09:30:33 -0500
Received: by bkcjm19 with SMTP id jm19so1083061bkc.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MFVMPbJYacuK2YgUTqkS1oX1dMwATSZOB6sQ9CJej0E=;
        b=dS0PkzD/DIzyOiR2FFAJZ0J4bxfyQ+y85cJSwsKXCyM+0hJNm6bgOJzrozTMqmOduK
         IXEVOf0WFAUbWRfVg5mfJtRg15HiSUs0nJsCyCKF6TwhmoqEDkXueGYoj/ArLhLKT2N8
         d6m9SGLU3e55303F/UAllQt9qkWK9fpFbJ4Io=
Received: by 10.205.42.130 with SMTP id ty2mr12622702bkb.55.1328106632192;
 Wed, 01 Feb 2012 06:30:32 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Wed, 1 Feb 2012 06:30:02 -0800 (PST)
In-Reply-To: <7v4nvb78om.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189513>

I'm going to address your comments soon (thanks by the way, making up
summary line for each option from git-pack-objects.txt was painful)
but since you like thought-provoking, check this comment out:

	/* Traditionally "pack-objects [options] base extra" failed;
	 * we would however want to take refs parameter that would
	 * have been given to upstream rev-list ourselves, which means
	 * we somehow want to say what the base name is.  So the
	 * syntax would be:
	 *
	 * pack-objects [options] base <refs...>
	 *
	 * in other words, we would treat the first non-option as the
	 * base_name and send everything else to the internal revision
	 * walker.
	 */

The last paragraph does not hold true anymore as far as I understand
the code. IOW it drops everything in argv after base name. Looking
back in history, the change was made by 8d1d8f8 (pack-objects: further
work on internal rev-list logic. - 2006-09-06). Nothing is mentioned
why it drops the remaining of argv. I suspect this is a regression and
we should reinstate the behavior as the comment says.
-- 
Duy
