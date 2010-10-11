From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 02/15] mingw: implement syslog
Date: Tue, 12 Oct 2010 00:28:40 +0200
Message-ID: <AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-3-git-send-email-kusmabite@gmail.com> <20101011221146.GB6277@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Mike Pape <dotzenlabs@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 00:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Qrn-0001No-4t
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 00:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904Ab0JKW3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 18:29:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55050 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903Ab0JKW3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 18:29:01 -0400
Received: by vws2 with SMTP id 2so1163034vws.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=oVPq95vgRZ0CP5+s30GMxZm5yzApPSDu6oFBtYFc5vI=;
        b=bEb8bMqi4yqzYBxur7LqZ/2wpaYzlXTM8TMc0aXQXbTpRhUTZqS2xotFiemp5cVy5r
         4P27MlFBfpEfWyYH1oOjlEob4pIKMZhZ/tlN/PtR2m1RGjPmWEvdOg9VV28rAgzA1QDM
         uhxOCYNnbaq3k5/SIsbZUAzgi85ZvQJgdkOX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Mn7dk/QuE/GwlDjUTOWdDQEojdS0wZf/nfZ2LbylHZ8y7q0kV6IzKYswdtqYFqa+jX
         LprhXCOPQKaIkTHEvaJbEX0fihfwWgJ632BXPBKuw6c99SZuADsyakzX70ibd1zB9/H0
         CpFgBTo8JuJnF9VZJbRy4g1xnLGBCm0/1Hzxc=
Received: by 10.220.195.75 with SMTP id eb11mr2098582vcb.10.1286836140157;
 Mon, 11 Oct 2010 15:29:00 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Mon, 11 Oct 2010 15:28:40 -0700 (PDT)
In-Reply-To: <20101011221146.GB6277@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158810>

On Tue, Oct 12, 2010 at 12:11 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Erik Faye-Lund wrote:
>
>> Strings containing "%1" gets corrupted by ReportEvent, so expand
>> "%1" to "% 1" before reporting.
>
> What is the symptom? =A0Can clients trigger this, and is it worth
> preventing them from doing so?
>

The string gets inlined into itself (with a limit of 100 expansions)
leading to string like "foo %1 bar" becoming "foo foo foo ... foo %1
bar bar bar ... bar". With our expansion, it becomes "foo % 1 bar"
instead.
