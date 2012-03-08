From: David Barr <davidbarr@google.com>
Subject: [BUG] fast-import: ls command on commit root returns missing (was:
 Bug in svn-fe: copying the root directory acts as if it's an empty directory)
Date: Thu, 8 Mar 2012 14:13:13 +1100
Message-ID: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 04:13:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Tn5-0003wX-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 04:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab2CHDNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 22:13:15 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:57654 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268Ab2CHDNO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 22:13:14 -0500
Received: by obbuo6 with SMTP id uo6so75770obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-system-of-record;
        bh=/+qUtMpdSaSdVd5iIT3ULHh7aDcylcixGBrcJZ83mfg=;
        b=EkekP2+lfRLT/N5lLJFdZk9664T6il62tBYV/xTpmZiLCdkSbqVOjrx7jZBYA03zFy
         AMLYqyXAE0X1xT0YSIOw5Nitu1FeveuH7SjBdkCL+xghZmTsoehMDjl7aMgRJqnjPFPP
         7O/KUsbcsuijWmh2/H8fM2rGVbyjGSlwAgKxVBmGhcU2ce4CMI+Sr5cBEXmXnI1hYYJg
         Yk4VY5yVBUFVgGqIoffmdAEPMAJVCw2qi9l1Dktd7LcxTtFfzZLylgiKYxzWxaf5VLng
         wNx6hRXBDNWLZtnb5gDO1DmU/2DsiO2Mp6sn7N30Z5+U74tL9yeb9z1c7QGn9wnyN0Ci
         BHSg==
Received: by 10.60.25.65 with SMTP id a1mr2238398oeg.23.1331176393731;
        Wed, 07 Mar 2012 19:13:13 -0800 (PST)
Received: by 10.60.25.65 with SMTP id a1mr2238390oeg.23.1331176393536; Wed, 07
 Mar 2012 19:13:13 -0800 (PST)
Received: by 10.182.154.74 with HTTP; Wed, 7 Mar 2012 19:13:13 -0800 (PST)
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmGZMGOa6UfKQnsIXv93EKMJjhThJw0aVsU7odMwIO3HCUxtAUMQ2VlguLhPDGranc9upQ0mYmtgXOgMdikYgG5l9omTKaP5RzjlGpyxQLZ413HN/eltZqzjtdYgjgZKj6XenNWWUwoq/mP5BM+lsP0RT3Nlw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192517>

On Thu, Mar 8, 2012 at 11:46 AM, David Barr <davidbarr@google.com> wrot=
e:
> Hi Andrew,
>
> On Thu, Mar 8, 2012 at 10:13 AM, Andrew Sayers
> <andrew-git@pileofstuff.org> wrote:
>> Here's a bug with svn-fe that I stumbled over while snorkelling thro=
ugh
>> repo madness. =A0I've tested it with the version of svn-fe in git.gi=
t's
>> master branch.
>>
>> Copying the root directory to a sub-directory (e.g. doing `svn cp .
>> trunk` to standardise your layout) doesn't correctly initialise the =
new
>> directory.
>
> This issue sounds very familiar, I wonder if there's an existing test
> or pending patch for it? Maybe Dmitry or Jonathan can recall.

I've stepped through the reproduction and the bug seems to arise when
the following command is sent to git-fast-import:

  'ls' SP ':1' SP LF

The expected output in this example is:

  '400000' SP 'tree' SP 'dd59323fe27c5647cb7ef15ce4637faae199c5f0' HT L=
=46

The actual output is:

  'missing' SP LF

--
David Barr
