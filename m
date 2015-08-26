From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Wed, 26 Aug 2015 23:25:47 +0200
Message-ID: <4CB47914-F04C-4E88-8D73-E00AFEFEF727@gmail.com>
References: <1440605295-73844-1-git-send-email-larsxschneider@gmail.com> <xmqqa8td3je7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 23:26:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUiCn-000379-W5
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 23:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbbHZVZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2015 17:25:52 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37729 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbHZVZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2015 17:25:51 -0400
Received: by widdq5 with SMTP id dq5so27077404wid.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0iiyA+WIcMVeBfHRCj4JplsqDkYrgPJ1U69gN0ecO+M=;
        b=W3UjmNDzl2gUYkJs03oWae2YwO+8WqqqxvxWx15Ahvdg+IFWW8w/VLeXKtk2DjVI0y
         mhBgMZTBu/P9RIzxHv/zdtgnpNk2GcXgXKm9Kh8CWN0FrLrF3Nug901ElVHlImJ0lb/J
         +cURi6tFBANK964iCSzdXD978k1efrmY6v3KxRVb6KyBXSDQKbL6HaVWlcvCxk19BZ7C
         oSFX1eHwJspuEdslPQC5WqHL3CZ4VQieuGxmYKB4U/t0jOuHxLoY64ffvCQrQtf/89q9
         jl/4PKnai7qPqif2RW7iWwkpzLFHCiKdSRBCgXURcxO5OsCSsPna0lTSrMP5GNAj6Z8S
         kVJg==
X-Received: by 10.180.76.232 with SMTP id n8mr15457056wiw.72.1440624350549;
        Wed, 26 Aug 2015 14:25:50 -0700 (PDT)
Received: from neu2l5rvy1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id fz16sm480963wic.3.2015.08.26.14.25.49
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 14:25:49 -0700 (PDT)
In-Reply-To: <xmqqa8td3je7.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276641>


On 26 Aug 2015, at 22:05, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> We run P4 servers on Linux and P4 clients on Windows. For an unknown
>> reason the file path for a number of files in P4 does not match the
>> directory path with respect to case sensitivity.
>=20
> Thanks, but is this still "For an unknown reason", or during the
> course of debugging you found the root cause, which is what led to
> this fix?
We are migrating away from P4 and therefore I haven=92t debugged the ro=
ot cause. The source of this problem is 100% P4 related. No Git involve=
ment at all. Maybe I just remove this paragraph?


>=20
>>=20
>> E.g. "p4 files" might return
>> //depot/path/to/file1
>> //depot/pATH/to/file2
>>=20
>> If you use P4/P4V then these files end up in the same directory, e.g=
=2E
>> //depot/path/to/file1
>> //depot/path/to/file2
>>=20
>> If you use git-p4 and clone the code via client spec "//depot/path/.=
=2E."
>> then all files not matching the case in the client spec will be igno=
red
>> (in the example above "file2"). This is correct if core.ignorecase=3D=
false
>> but not otherwise.
>=20
> This sentence is hard to grok.  What are you describing?  Solution?
> Current problematic behaviour?  Desired behaviour that the patch
> attempts to obtain?
I tried to describe the situation that causes the strange behavior.

>=20
> If I paraphrase it like this, did I understood you correctly?
>=20
>    The current code always ignores paths in wrong case that do not
>    match client spec.  It is correct to ignore them when
>    core.ignorecase is not set; //depot/path/ and //depot/pATH/ are
>    different things in that case.
>=20
>    But it is a wrong thing to do if core.ignorecase is set to true.
>    Let's make sure we avoid it by downcasing the depot_path when
>    core.ignorecase is set to true.

How about this:

-----------------
The current code always ignores files with paths that do not match the =
case of the paths defined in the client spec. This commit changes this =
behavior and obeys these files if =93core.ignorecase=94 is set to "true=
=94.

Example:
A P4 repository contains the following files:
//depot/path/to/file1
//depot/pATH/to/file2

The P4 repository is cloned with git-p4 and the following client spec v=
iew:
//depot/path/=85 //client/...

The cloned Git repository will contain only the following file:
to/file1

=93file2=94 is not present in the cloned Git repository. If =93core.ign=
orecase" is set to =93true=94 then path case sensitivity is ignored and=
 =93file2=94 will be present.
=97=97=97=97=97=97=97=97

Thanks,
Lars
