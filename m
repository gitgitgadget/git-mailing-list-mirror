From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of fork
Date: Thu, 7 Jul 2011 20:39:51 +0200
Message-ID: <CABPQNSYsBjtyGAinh2c6YBXHezpADirhr9_hOknSah-o1oy=0Q@mail.gmail.com>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
 <1310038989-5724-4-git-send-email-kusmabite@gmail.com> <4E15F90F.8090300@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 20:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QetV8-0002Tu-5S
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab1GGSkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 14:40:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54244 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab1GGSkc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 14:40:32 -0400
Received: by pvg12 with SMTP id 12so638148pvg.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Wc3mzkLCudCgl7hKuQ2flWH49MM5Bgl3SfEzqUp9AE0=;
        b=OVV2NmhMQgwHq4A4BF7ukM5ZWQe9wwT9FStXialr1IgTnNociW/udCNHN0Mp7i8LP5
         YQXJmG7W3CAj577nCX+w+AELR0vAC2+lCEEHKGYkKwG3VGZdlYGQ/Ce9YItdZL4tqAP9
         4InvxIBycMyJD+6pAcIZLx621EoBmpgX4vdyk=
Received: by 10.68.40.161 with SMTP id y1mr1558193pbk.156.1310064032172; Thu,
 07 Jul 2011 11:40:32 -0700 (PDT)
Received: by 10.68.43.198 with HTTP; Thu, 7 Jul 2011 11:39:51 -0700 (PDT)
In-Reply-To: <4E15F90F.8090300@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176767>

On Thu, Jul 7, 2011 at 8:21 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 07.07.2011 13:43, schrieb Erik Faye-Lund:
>> - =A0 =A0 if (!enter_repo(buf, 0))
>> - =A0 =A0 =A0 =A0 =A0 =A0 die("'%s' does not appear to be a git repo=
sitory", buf);
>> -
>> =A0 =A0 =A0 /* put received options in sent_argv[] */
>> =A0 =A0 =A0 sent_argc =3D 1;
>> - =A0 =A0 sent_argv[0] =3D "git-upload-archive";
>> + =A0 =A0 sent_argv[0] =3D "archive";
>
> Is git-archive a valid replacement of enter_repo() followed by
> git-upload-archive?
>

What do you mean "enter_repo() followed by git-upload-archive"? Don't
you mean "enter_repo() followed by write_archive"? It does work for
me, and the test-suite didn't reveal any breakages either.

write_archive gets called by both versions, but my version doesn't
call enter_repo directly. It is however called by git-daemon before
starting git-upload-archive, so perhaps that's why it works for me.
And that's a regression indeed; I don't respect the path-argument. So
expect a new version over the week-end ;)
