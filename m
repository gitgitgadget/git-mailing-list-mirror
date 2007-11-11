From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t7005-editor.sh: Don't invoke real vi when it is in GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 12:49:57 -0500
Message-ID: <2AE2E502-7942-449E-B847-75876A5DAF37@silverinsanity.com>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <1194802691-27610-1-git-send-email-B.Steinbrink@gmx.de> <Pine.LNX.4.64.0711111742010.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	aroben@apple.com, dak@gnu.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGws-0001aZ-Sd
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbXKKRuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 12:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbXKKRuB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:50:01 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:45030 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbXKKRuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 12:50:00 -0500
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3DD331FFC10F;
	Sun, 11 Nov 2007 17:49:59 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0711111742010.4362@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64487>


On Nov 11, 2007, at 12:44 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 11 Nov 2007, Bj=F6rn Steinbrink wrote:
>
>> The git wrapper executable always prepends the GIT_EXEC_PATH build
>> variable to the current PATH, so prepending "." to the PATH is not
>> enough to give precedence to the fake vi executable.
>>
>> The --exec-path option allows to prepend a directory to PATH even =20
>> before
>> GIT_EXEC_PATH (which is added anyway), so we can use that instead.
>
> Hmm.  This will probably stop working when you do not have git =20
> installed,
> because you now tell git to search for git programs in ".", where =20
> they are
> not.  Probably git-commit executes your installed write-tree, commit-=
=20
> tree
> and friends, instead of the compiled ones.

You are wrong there.  From exec_cmd.c:setup_path() (lines 51-54):

     add_path(&new_path, argv_exec_path);
     add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
     add_path(&new_path, builtin_exec_path);
     add_path(&new_path, cmd_path);

So the path with this patch will still include the build directory =20
before the install location.

~~ Brian