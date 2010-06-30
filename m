From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 3/3] git-instaweb: Don't assume Apache executable is named 
	apache2
Date: Wed, 30 Jun 2010 11:38:28 -0500
Message-ID: <AANLkTimfy0F7x-WZpfJ0J45jUWjb9lrJt99jY0fO6ZzC@mail.gmail.com>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
	<1277865900-25044-3-git-send-email-dpmcgee@gmail.com>
	<7v39w48q4a.fsf@alter.siamese.dyndns.org>
	<AANLkTikYNVLM9MrmL819__Viap7ucvmrs7faeC4tdDmn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 18:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU0J5-0005FG-CJ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 18:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab0F3Qid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 12:38:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47001 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab0F3Qic convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 12:38:32 -0400
Received: by fxm14 with SMTP id 14so638854fxm.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=wmW4n1ocfGxRL7B0qr7gJAp2h58jbqgrRx2VFsmzzy0=;
        b=lUmYBPqQ298ZmlrdSM4W/EE9K1I0S7C5jtqrEifjj1VSH3jlAvgvaCg1cOPej16gzm
         Q0alYpU3bKTzG/oqttKE7EBYgSLiD3LFlti4q0cZN9LgeDtJV/rji37Hy9aKzGX7Fk6Z
         9hHN5LBigasIuW6BI7tV7rmtbfdxfS+y3I81M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=eBxCbkU7RTQxCOGobaE/EQn8iwrBoEnmAz+L+AoW3FErEU3eg4p2We7a/lfhwsCvgF
         Wj4D6AevnOl+mN4hOZBCwfKo1VJvFKEw4LhWZyQ95Ey/TEIa3Ke1LCtmoZE2BmffycLb
         j80tRBtY/leRSd6wsF8/DL/FgoxxnMQyh+Vrc=
Received: by 10.216.88.20 with SMTP id z20mr7434639wee.94.1277915908868; Wed, 
	30 Jun 2010 09:38:28 -0700 (PDT)
Received: by 10.216.165.142 with HTTP; Wed, 30 Jun 2010 09:38:28 -0700 (PDT)
In-Reply-To: <AANLkTikYNVLM9MrmL819__Viap7ucvmrs7faeC4tdDmn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149980>

On Wed, Jun 30, 2010 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> On Arch Linux, we keep the original 'httpd' name for the exectuable =
and
>> don't rename it or the path to the modules.
>
> Sorry, but I cannot parse the last 6 words here.

On Arch Linux, the executable for the Apache HTTP server keeps the
'httpd' name and is not named 'apache2'. The path to the server
modules also contains 'httpd' rather than 'apache2'.

>> Remove some of these assumptions
>> and add the httpd name in where it may be required.
>> ...
>> =C2=A0resolve_full_httpd () {
>> =C2=A0 =C2=A0 =C2=A0 case "$httpd" in
>> - =C2=A0 =C2=A0 *apache2*|*lighttpd*)
>> + =C2=A0 =C2=A0 *apache2*|*lighttpd*|*httpd*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # yes, *httpd* covers *l=
ighttpd* above, but it is there for clarity
>
> That may make things work better on Arch but I wonder if there are
> platforms that allow users to point at their favorite, non-Apache, ht=
tp
> server with a canonical name "httpd" that gets broken by this change.=
 =C2=A0Am
> I being too paranoid?
I think you are being overcautious. Even in this case, you can specify
the real name of the web server through git-config or command line
parameters to make sure it picks up the right settings. In addition,
any web server named 'httpd' wouldn't have worked before anyway so we
aren't regressing here. Finally, I've not encountered any platform
that does this kind of canonical naming as web servers have very
different command line flags and interfaces anyway.

> Other two patches looked very sane. =C2=A0Thanks.
No problem.

-Dan
