From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] i18n.pathencoding
Date: Wed, 5 Sep 2012 18:11:12 +0700
Message-ID: <CACsJy8ARmPwELFhdvu_Y2kZNbYNgTzoqLzriH2oB7WtxM8D7hg@mail.gmail.com>
References: <201209010811.33994.tboegi@web.de> <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com>
 <7vvcftbt8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 13:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9DWW-00047G-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab2IELLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 07:11:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43444 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab2IELLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 07:11:43 -0400
Received: by iahk25 with SMTP id k25so611834iah.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8mDiWlGW0WNyg+4mGP+Ea8mo46PBbCFvCctnLqHBYOE=;
        b=bW7N645kv11ydnlijTr7mDhjFGT1gO9KGgRQl033jQFoNFiA3eT2147RLeqkQEwyc6
         7gk5jTfba7VKatFf7v1H9JGrZV57u1O6JcdzZ0snP9YIsV7ZaF4aNwjhorZaTbEpRLdr
         d84EFbIu0LlOEZ1+EcRPcx09+DYMitCGwrrGY4f3moKZWCLVfICbJBuj07YGB3jZrtGG
         WrPpisTuto8xQ31onVZuZbX5niHH+7aMSRVU9SxxBNpkgEMfroN5s9pasalTbDN6taiU
         lcTwKTuHVxt6r0nVMxX2je0UYQz2ajNpFeRjow6qpwfnBHDvdNmQm+ASUPP4FlgkQKlN
         G1ZA==
Received: by 10.50.85.134 with SMTP id h6mr9590226igz.2.1346843502655; Wed, 05
 Sep 2012 04:11:42 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 5 Sep 2012 04:11:12 -0700 (PDT)
In-Reply-To: <7vvcftbt8o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204811>

On Wed, Sep 5, 2012 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> On Sat, Sep 1, 2012 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>>> @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv, =
const char *prefix,
>>>                 usage_with_options(usagestr, options);
>>>         }
>>>
>>> -       precompose_argv(argc, argv);
>>> +       reencode_argv(argc, argv);
>>>         return parse_options_end(&ctx);
>>>  }
>>
>> If you have to re-encode command line arguments, what about paths
>> coming --stdin or a file?
>
> That problem is inherited from the MacOS precompose topic this one
> builds on.  Not that it is unimportant to fix, though.

On fixing that. 76759c7 describes the change as:

    The argv[] conversion allows to use the TAB filename completion don=
e
    by the shell on command line.  It tolerates other tools which use
    readdir() to feed decomposed file names into git.

How come git's internal conversion helps TAB filename completion,
which is done before git is executed? If it's the pathname output from
git that helps tab completion, then perhaps we should convert at
output time rather than input, by piping all the output through a
converter when we know the output is textual. That keeps all paths in
the same encoding internally (I hope).

Just two cents. And I'm not against i18n.pathencoding or anything.
--=20
Duy
