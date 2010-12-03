From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Fri, 3 Dec 2010 18:57:37 +0100
Message-ID: <AANLkTik=pGND-EYQ2HYTmevVd5S9pXZBNSpDsnafOF2V@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com> <AANLkTimAdrqYezL5jf9OR_J5XdYW-KYhYy9n_VQAUSD8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:58:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZtT-0006QS-TU
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab0LCR56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 12:57:58 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52847 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0LCR56 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 12:57:58 -0500
Received: by iwn6 with SMTP id 6so126225iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dRx7Oh7gnbQaOoNsGrZ/ws8y3cQxBqkSmaMsj+ah04c=;
        b=EpsRNkHWRchiAIa8q2K1Rl+ZzjpLHwmqAtlsIOTrxPg/DnEq04vYn7OSg4eQyH6/IC
         z+0w9AlasDcm6NaR7VcwdLveDDyPlJmTf3ArCP9OO7aTuxrK/DyDYCDdyRhdyOqXAvsx
         1GzZVbYWn3ppV4WHRaVNMPfbKLOF5JhO/Azm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jlDiTwo3LVFRzBIERcfRbHSGhpOvaqBxYUGE88RqS1kIgtJJOv0vVZRSLIzFrKZ9sg
         fkSloVbCdBi8P8G+9tyB27n/7G/zYvYFuqCjgKeM2SYav9lZAOO0ewgWlHcT+3tNTQRN
         Eo9G02iJmje8deYyMNQdOrSLw+U9wNe8313kw=
Received: by 10.231.12.131 with SMTP id x3mr2152444ibx.31.1291399077286; Fri,
 03 Dec 2010 09:57:57 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 09:57:37 -0800 (PST)
In-Reply-To: <AANLkTimAdrqYezL5jf9OR_J5XdYW-KYhYy9n_VQAUSD8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162820>

On Fri, Dec 3, 2010 at 6:40 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
>> =A0Custom commands may also be specified.
>>
>> +If no default browser is specified, and /usr/bin/x-www-browser
>> +(under X) or /usr/bin/www-browser is present, they are used to dete=
rmine
>> +the browser to use.
>
> It looks like /usr/bin/gnome-www-browser is missing.

Good catch. I'll add it.

>> + =A0 =A0 =A0 echo >&2 "$basename ($browser) is not a supported brow=
ser, skipping"
>
> Why not:
>
> echo >&2 "$basename (from $testexe) is not a supported browser, skipp=
ing"
>
> ?
>
> Otherwise we might get something like:
>
> "newbrowser (newbrowser) is not a supported browser, skipping"

I rephrased it to:

	echo >&2 "$testexe (detected as $browser) is not a supported browser, =
skipping"

>> @@ -133,7 +185,7 @@ if test -z "$browser" ; then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
>> =A0 =A0 =A0 =A0done
>> =A0 =A0 =A0 =A0test -z "$browser" && die "No known browser available=
=2E"
>> -else
>> +else if test -z "$browser_path"; then
>
> Now that you reset $browser above, I am not sure this test -z
> "$browser_path" is useful...

I believe it is. If the *www-browser detection was successful,
_that's_ what we want to launch, so we want to skip the
init_browser_path in that else section, which we would hit if we
didn't check for $browser_path. We also don't want to repeat the
valid_tool check, since we know it's valid already.


--=20
Giuseppe "Oblomov" Bilotta
