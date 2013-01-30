From: Jed Brown <jed@59A2.org>
Subject: Re: Updating shared ref from remote helper, or fetch hook
Date: Wed, 30 Jan 2013 02:06:41 -0600
Message-ID: <874nhzksby.fsf@59A2.org>
References: <87ehh5lw9j.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 09:07:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ShJ-00076E-M1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 09:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab3A3IGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 03:06:49 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:63764 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab3A3IGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 03:06:46 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so1920504iak.10
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=v2cmy+iEgE2HLmujjjL757Ec+tSjRZ+KY43fuNZkqms=;
        b=eDh2QlnSCXTisjuyktdJ4HFSH1tCWyBOZVcsT1Z4ugfyu7H7sZn8hTxzaZu13ydz5m
         Pqui8+PE9CNvS2/wMR6oIA8gawdViRTzx0vKu7B0X1PN16Jxcja5jxTieCljCjQ90Gl6
         5pokE3uWkC9NPOwcbXpcu2kVRNnogj9mTBdRm6eZYg2zP/vcOWC2qoPFUHW5LjY7zRoi
         YQPhA71ZlX+ybLzmL/g6AQpipG+4HfA5eI9Z0fh0tjwvk9GCOKgljvc4+7W7FK8dY8xh
         0wT4nA31RDhhrSauPC3sJF1ICsE30+A+ZN4lWHHc6xnpRgv0IyYX8Qnt4gthHuyMlI+W
         a09g==
X-Received: by 10.43.134.8 with SMTP id ia8mr1752231icc.42.1359533205946;
        Wed, 30 Jan 2013 00:06:45 -0800 (PST)
Received: from batura ([38.69.41.115])
        by mx.google.com with ESMTPS id c3sm5123033igj.1.2013.01.30.00.06.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 00:06:43 -0800 (PST)
In-Reply-To: <87ehh5lw9j.fsf@59A2.org>
User-Agent: Notmuch/0.15 (http://notmuchmail.org) Emacs/24.2.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215005>

Jed Brown <jed@59A2.org> writes:

> I'm working on an hg remote helper that uses git notes for the sha1
> revision, so that git users can more easily refer to specific commits
> when communicating with hg users.  Since there may be multiple
> concurrent fast-import streams, I write the notes to a private ref
> (refs/notes/hg-REMOTE), to be merged eventually using
>
>   git notes --ref hg merge hg-REMOTE*

A related issue is that when a remote helper replies to an 'import' with
_only_ a commit in refs/notes/, git (fetch or pull) produces an error
message like

  error: refs/notes/hg-84b3865b750a567acb16929c21e14c4a45a5639b does not point to a valid object

but successfully updates the ref (which is indeed valid) and returns
0. I have not been able to determine what exactly git thinks is
invalid. As long as there is at least one non-notes commit in the
stream, no such error message is produced.

Is this behavior intended?
