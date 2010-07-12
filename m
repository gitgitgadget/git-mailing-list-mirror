From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Mon, 12 Jul 2010 08:16:26 +0000
Message-ID: <AANLkTinGsIqy-rG8um1E7_zfla1KwsO2Z26JnchXaRLd@mail.gmail.com>
References: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
	<alpine.LFD.2.00.1007112327150.10598@xanadu.home>
	<AANLkTindliEmS2XhH8B1dUyo-v-CzpLQBqZakOaNnARW@mail.gmail.com>
	<20100712061608.GA6140@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 10:16:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYEBm-0007JN-Dm
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 10:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab0GLIQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 04:16:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34404 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab0GLIQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 04:16:27 -0400
Received: by iwn7 with SMTP id 7so4394969iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ryCsgGV+N1oT+ozeIDULDxBm0ZJTePXLN8MtDgAdLrM=;
        b=GOU1uUQ7QknwYyOWNyTzLdlbVD/yojJ1+6OFDWSkMxRtt5puArlgq0phpMqx13DwFG
         +2ayW73Y6s/eST3lEdSEZI9YMBei0lBjEcjDV/b/2tiFRQgQXeb5xkawR/LjqNHN+k1Q
         F+O97ZoNuEF0+Od5LhvfKgyrOtIcc9xLOsw/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UJa6Zvwx3pDvNW9p5P+dDgoOxSYVC7BjAI9vOOinGI1utIJgBc9M4hL1sBBR4yqtIv
         iEJ0gvFEftA8Uh/VmrdSXYH6It+obIr2/3kIBcnK10vodb2sGK7K+8ZnxzjdOuzj3+XI
         9PEm+CQ1TQS9mhD5HrR202ztoFYfsRM7pxmkQ=
Received: by 10.231.173.144 with SMTP id p16mr7176178ibz.108.1278922587065; 
	Mon, 12 Jul 2010 01:16:27 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 12 Jul 2010 01:16:26 -0700 (PDT)
In-Reply-To: <20100712061608.GA6140@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150801>

On Mon, Jul 12, 2010 at 06:16, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi =C3=86var,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Unless that's due to some unreproducable heisenbug you could get the
>> trash directory by running the test with --debug.
>
> So what should I do after noticing a heisenbug?

Run the test again with --debug. The test library and the commands
it's calling don't live in the same address space. A "heisenbug" will
probably be just as reproducable with --debug and without --debug.

>> These trash directories are explicitly temporary, and
>> should be cleaned up as the shell exists.
>
> When tests learned to remove the trash directory in test_done in
> v1.6.1-rc1~336^2~1 (Enable parallel tests, 2008-08-08), that was not
> the rationale; it was rather to avoid too many trash directories
> piling up. =C2=A0If a test exits by mistake with =E2=80=98exit=E2=80=99=
 or fails with =E2=80=98-i=E2=80=99,
> the one or two scratch directories involved are still kept for
> debugging.

That's the original rationale, which is fair enough. I think the
behavior should be to clean up temporary files when the test exits,
not just when it's done executing.

> So you can see why a person would be reluctant to change this for
> aesthetic reasons only.

The reason I want to change it is that as I'm hacking Git I often run
the tests but kill them before they've completed, because if I'm
e.g. testing the test library itself I'm content with having only 10
tests pass before I continue improving it.

If I keep doing that (along with --jobs 20 and --shuffle) I'll
eventually pile up ~200 MB of trash. That'll exceed the limits of my
ramdisk and I'll have to grudgingly do rm -rf trash* again.

But maybe people such as yourself depend on the current behavior with
regards to SIGINT. I don't feel strongly about it, and having to
remove trash is a minor annoyance.

If it's being used it should be kept. I just assumed that it was an
omission in the cleanup routines.
