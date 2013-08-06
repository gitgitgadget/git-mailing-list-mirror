From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: About close() in commit_lock_file()
Date: Tue, 6 Aug 2013 15:36:52 +0700
Message-ID: <CACsJy8DquJj1qVawKfrbZY+2WLC54Gskizs1sxZ_j1yutBkbdA@mail.gmail.com>
References: <CACsJy8By1cpPZ5QyVd6VhKSkd-y_E6pTYdDimK9P0wXia-uMqg@mail.gmail.com>
 <52009A90.7050701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 06 10:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6clq-0004SV-BA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 10:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab3HFIh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 04:37:27 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33588 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab3HFIhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 04:37:23 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so182195obb.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dqHjEvA/81BFmyrnKAtUHPQgcANzezfrC0aKzSMGGIg=;
        b=DKSbuKswO70e3n/BEKbSFdMdy4cS4hMamAp1kuIcYaOpm6fMgnheuVP25Ag16VL9qo
         IWFys7zuSMvPaPbgXpV+EmYbtXKq86LJxKhsVlE/SnJF8TD9rmfF0rJTipPpY3/cByCY
         Sm9mvXoS33XgAi2ZobdHz33vWVNgCQMy4pAM91gWSigNgU+IB66gVLvm+8Oa28jo5CsW
         cjNUOaiYYX5e3hgWivOi/3yXVBmitD3fqtzxI+ANUhF2JxcsBPI375vrNpkOTuV3vLWa
         MKqAH5GNZvkQ3jZy3SUPkZNYRVyniUTv8wKbj7lAbX+BId2qyYHR/phmWUb1+5bYCbq5
         uD7Q==
X-Received: by 10.60.142.130 with SMTP id rw2mr137632oeb.62.1375778242371;
 Tue, 06 Aug 2013 01:37:22 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 6 Aug 2013 01:36:52 -0700 (PDT)
In-Reply-To: <52009A90.7050701@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231731>

On Tue, Aug 6, 2013 at 1:41 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/5/2013 16:23, schrieb Duy Nguyen:
>> close() is added in commit_lock_file(), before rename(), by 4723ee9
>> (Close files opened by lock_file() before unlinking. - 2007-11-13),
>> which is needed by Windows. But doesn't that create a gap between
>> close() and rename() on other platforms where another process can
>> replace .lock file with something else before rename() is executed?
>
> First, files manipulated by commit_lock_file() are to be opened only using
> lock_file() by definition. Opening such a file in with open() or fopen()
> or renaming it via rename() without using the lockfile.[ch] API is
> possible regardless of whether commit_lock_file() has closed the file or
> not. Such manipulation is already undefined behavior (from Git's point of
> view), and there is nothing we can do about "misbehaving" processes.
>
> Second, lock_file() uses O_CREAT|O_EXCL, which fails when the file exists,
> regardless of whether it is open or not.

The second process could unlink(.lock file) first, then open it, even
using lock_file(), but I think that falls into your "first" and is an
invalid case from git point of view, so..

> Conclusion: There is no problem.

Agreed. False alarm.
-- 
Duy
