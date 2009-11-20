From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 1/2] t/lib-http.sh: Restructure finding of default httpd 
	location
Date: Thu, 19 Nov 2009 19:30:34 -0800
Message-ID: <905315640911191930rc33cabdr290b534ffbe85690@mail.gmail.com>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com> 
	<76718490911191914n23d067b8teb17907de9ec83d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, drizzd@aon.at,
	gitster@pobox.com, spearce@spearce.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 04:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBKD7-0002ZB-Be
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 04:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536AbZKTDat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 22:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbZKTDat
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 22:30:49 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:42563 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277AbZKTDas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 22:30:48 -0500
Received: by pzk1 with SMTP id 1so2101905pzk.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 19:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Th0IXIA6e3po9n0tcZge03/Ulny0xmh0uQ7BJD1Z6hE=;
        b=qM0ipEa/qmDiFJT04WDVkFxBKFZ19jeoFTjXE67tmDUMvCOfGWXaxyTJrt7V2Lk87S
         hq2v/roIMDYL12PmobjUXpSogvRmxf/6OPb7xeXcGIaHK2J19IS7COnPkjRykWjnOsDI
         c033mlAcW2HWocKZnI9Wucq69p3iD76UqkiHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=RDgiYcAWqxLnX35vhAVoluF6NgIrhDWCe4RIdY/hEbk8EbT+WMFAsNM88N7hCnySoB
         dztbUK/Eqx6cRP/+7soFdUQMQ3j5AmlP8cnd2xdzcg92QsDu7D/Vh9k88VMhChyqk/8d
         pL+Csm8pi0c+0n9QwEtcFV7X9lGP/nZGT3+Tk=
Received: by 10.142.55.20 with SMTP id d20mr99249wfa.322.1258687854154; Thu, 
	19 Nov 2009 19:30:54 -0800 (PST)
In-Reply-To: <76718490911191914n23d067b8teb17907de9ec83d5@mail.gmail.com>
X-Google-Sender-Auth: 1e1f1e29219c83a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133302>

On Thu, Nov 19, 2009 at 7:14 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Thu, Nov 19, 2009 at 8:22 PM, Tarmigan Casebolt
> <tarmigan+git@gmail.com> wrote:
>> uname might not be the best way to determine the default location fo=
r
>> httpd since different Linux distributions apparently put httpd in
>> different places, so we test a couple different locations for httpd,
>> and use the first one that we come across. =A0We do the same for the
>> modules directory.
>
> Perhaps testing the distribution and looking in the known location fo=
r
> that distribution then? That said, going through a list of well known
> locations should work too.

Is there a nice way to test the distribution?  Seems to me like doing
that might be more complicated and also more fragile.

>> +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
>> +do
>> + =A0 =A0 =A0 test -x "$DEFAULT_HTTPD_PATH" && break
>> +done
>
> Unfortunately this leaves DEFAULT_HTTPD_PATH as the last item in the
> list even if the test does not pass. You can add an empty item to the
> end of the list if you want to do this way.

Yes.  I think this is how it was before though too, and it is caught
later in the script with the LIB_HTTPD_PATH setting and testing.

>> +for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '/=
usr/lib/apache2/modules' \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '/=
usr/lib64/httpd/modules' \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '/=
usr/lib/httpd/modules'
>> +do
>> + =A0 =A0 =A0 test -d "$DEFAULT_HTTPD_MODULE_PATH" && break
>> +done
>
> Ditto.

Yes.  Again, this is still more thorough than before, but in this case
the script does not check later.  Perhaps the script should test this
value and test_done if it's not a directory?

Thanks,
Tarmigan
