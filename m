From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 19:23:32 +0200
Message-ID: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgggM-00051I-NK
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab1GLRXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:23:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65171 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab1GLRXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:23:32 -0400
Received: by vws1 with SMTP id 1so3615830vws.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=UfW0v4K+3e6cRWokmJ1ViPSWq54wzOGEIMfvyJD2+6g=;
        b=ASeD68O1Tca0/JSeXzkrhV0Tykb0OsdoPyIIwKe7dKwwc14+mOZ7qt+a9S7RD2xGDO
         l7btq7HFHNTbILvE7kCxTc8edGZUBOTJdCJ1BuCuukUtddsMtCDnxzb7EyOxVpF0wEmr
         /rPkpbe3NrxYy/3l9HpwHsSIT+MnxUSH/0U04=
Received: by 10.52.93.49 with SMTP id cr17mr198481vdb.463.1310491412236; Tue,
 12 Jul 2011 10:23:32 -0700 (PDT)
Received: by 10.52.185.105 with HTTP; Tue, 12 Jul 2011 10:23:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176954>

On Mon, Jul 11, 2011 at 23:24, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> The question is: should the user be able to disable logging of the
>> hard-coded values. With your examples that would be possible. But I
>> think we should not allow that.
>
> You have to justify that position. I do not see any reason to forbid
> myself from declining reflog for refs/remotes/ while still logging the
> updates to my refs/heads/.

I don't, because I don't care. But I care for a simple way to always
log ref updates with update-ref. Thus, I take you justification for
being able to do so and provide here a proposal for this:

What: Control the refs which are honored by core.logAllRefUpdates.

How:

Introduce a new config variable named core.autoRefLog. This variable
is a multi var. The default value is:

    [core]
        autoLogRef = heads
        autoLogRef = remotes
        autoLogRef = notes

This list must be initialize at runtime. Because older repositories
won't have them in existing config files.

The value given needs to be a valid ref, without leading or trailing
slashes, and wildcards. The names will be prefixed with 'refs/' and
suffixed with '/'. The list is checked against the ref to update, if
any of the values is a prefix of the given ref, than the update will
be logged, regardless whether the log file exists.

Setting core.autoLogRef to the empty value, will reset the list.

Usecase:

To be able to always log ref updates from update-ref in one call. For example:

    git -c core.logAllRefUpdates=true -c core.autoLogRef=frotz
update-ref -mreason refs/frotz/master <new-value>

Please note, that there is also the "HEAD" ref, which is honored by
core.logAllRefUpdates. I don't know how this should be handled by
core.autoLogRef. I have no problem that this will be hardcoded.

Kind regards,
Bert

PS: I asked for the typo in my applied patch, but you are only on Cc,
which should have been To. Please feel directly asked. Thanks.
