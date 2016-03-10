From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Thu, 10 Mar 2016 07:39:46 +0700
Message-ID: <CACsJy8CbxyJQ7HYy6GaqRhemeSz_upB6jQ7HMX0Vk+tr7bBz3w@mail.gmail.com>
References: <xmqqy49siin2.fsf@gitster.mtv.corp.google.com> <1457521693-26141-1-git-send-email-pclouds@gmail.com>
 <xmqqoaanilia.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
	Charles Strahan <charles@cstrahan.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:40:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adoeN-0005ta-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934524AbcCJAkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 19:40:20 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34927 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcCJAkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 19:40:17 -0500
Received: by mail-lb0-f181.google.com with SMTP id bc4so89793405lbc.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dfYO+joTXA90/cztO0KNPT5r3Ub/3FNDWaJvy3ZQ8bM=;
        b=oHhtuZMTNB9WdbLHJ6+kZrsac8mbUrglkB1N+GU08m9R9EDa1cRJuLHkQcIR7SHzdI
         KEbyvHGWoqWHNzdWqfJl0fg/qOmCUW+GtS63NT67PiZOpZ2CKLjLQKlBEEYiNPaumP8P
         CTu8Yj5purTDCDUf3unSXhYdgHU9dTGJ5zaCwVLUwIKNcWJIBSn0644Zry2fnXwQcNVH
         WjLRNhgOxCNQPs/bY5Q7LwF1uHklqtee77pUa01tA9oNIYEtaLPeCsvRebwIEqaIdGwj
         wprckXNrBPBoydp9cl2T0Th9tqxQj5rtpshTrFssY8/ac3qMbNmk2fO5Be/58zDJxO7A
         WOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dfYO+joTXA90/cztO0KNPT5r3Ub/3FNDWaJvy3ZQ8bM=;
        b=BRx87d0Tskc3YtjtOX6qO31iUMVlHVGP1ntimrYUUH5zgiMOBaHs8GqvPD1uy6q43Z
         vBvMQQUwWdkWYq7Z1sMVqKBEcIrYXxYLpANhWMY7EtCyZP08arll1Ec/aRq0g9NF5AlW
         Q4OAdYwoHdrey/XDO0C6ND9XMHgOuQ4kIQCSMon83O9ToYxexLlmuQTNZTlv6I48Vv/E
         KpD0M2dgmFanmUj9zFPKF4WPjkwdye0hTDElu6/gYGc2r0xtwZvQIRCZXAndEkKPLIkq
         +940NgIDiGhvT5+cCgM39h7kOd6UkQhJVgCzbkecosI5PvzT67LZ6z9H8tsYnzkFQ59j
         K+zg==
X-Gm-Message-State: AD7BkJLcjJ1RNOfm4svKHMYsAEmmg5RNfO4Nj/faz4d8/Hlay5VrAw0QTS0TSoi6e96WkT3vbs1NYA+aelhkTQ==
X-Received: by 10.112.150.133 with SMTP id ui5mr198583lbb.12.1457570415951;
 Wed, 09 Mar 2016 16:40:15 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Wed, 9 Mar 2016 16:39:46 -0800 (PST)
In-Reply-To: <xmqqoaanilia.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288591>

On Thu, Mar 10, 2016 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Side note, it's probably a bad idea to use basename matching on a
>> negative rule (ie. no slashes in the pattern) because what the patte=
rn
>> says is "re-include _any_ directory named 'dir'", not just the direc=
tory
>> "dir" at right below this directory.
>
> I am not sure I agree with this comment.  When we say '.depend/' in
> our .gitignore file, we do want to ignore everything in the
> directory with that name anywhere in that tree.  Perhaps '!include/'
> followed by '*' may be a good way to pick only the header files that
> are found in any directory with that name anywhere in the tree in a
> similar fashion.  It certainly is a disappointing comment if made by
> somebody who wants to make 'dir' and '!dir' behave in a more similar
> way, I'd have to say.

Hmm.. yeah personal view. I'll take this out.

>> In both cases, we want to test if the pattern matches a parent
>> directory. match_dir_component() is for this purpose.
>
> I do not follow.  I would understand "In all cases, we want to
> behave as if we are testing the _full_ path against the pattern",
> though.
>
> IOW, "dir/file1" matches '*' (because 'file1' and '*' matches),
> '!dir/' (because the pattern is "everything under dir/ directory),
> and nothing else in the pattern list, and the last match
> wins---which happens to be negative ignore, hence dir/file1 is not
> ignored.

Yep, bad phrasing.

>> We do want to be careful not to get back too far. Given the file
>> foo/bar/.gitignore, we should only check as far back as foo/bar beca=
use
>> this .gitignore file can never match outside that directory, which i=
s
>> "toplevel" in the above paragraphs, to begin with.
>
> Yes.  But isn't that what exclude_stack mechanism already gives us?
> That is, when you are not looking at a path inside foo/bar/, entries
> stored in foo/bar/.gitignore will not participate the determination
> of the fate of the path.
>
> I am not sure why you have to say this.  Puzzled...

Naively speaking, in order to fix this without reorganizing a lot of
code, when given path 'foo/bar/dir/file1' and the pattern '!dir/', we
first still test if the full path "foo/bar/dir/file1" is a directory,
then we cut "file1" out (pretend that we are in foo/bar instead of in
foo/bar/dir) and test again the full path, which is just foo/bar/dir,
if it's a directory. Repeat again and again. This trick does not go
through the normal prep_exclude(), so patterns are not popping out
when .gitignore should not be used any more.

The implementation is a bit different. Instead of going up one level,
test, and go up again, I construct the new pattern "foo/bar/**/dir/**"
and match it (only once) against the original full path
foo/bar/dir/file1. The note was there because I would have just
constructed "**/dir/**" instead and matched too much.
--=20
Duy
