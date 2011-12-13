From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 1/2] wrapper: supply xsetenv
Date: Tue, 13 Dec 2011 19:52:34 +0100
Message-ID: <CABPQNSZ_r4u-yXtEGw8duZyoN3SdF5p+7vabz2qqS161kgkHWQ@mail.gmail.com>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
 <20111213181602.GB1663@sigill.intra.peff.net> <7vwra0uxqo.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 19:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXTm-00050y-Et
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab1LMSxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 13:53:18 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41990 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab1LMSxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 13:53:15 -0500
Received: by pbbb2 with SMTP id b2so333442pbb.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=QbRV+tMDuw5TBAifdAmebD9NTxbiOLUehXPiMyh3Ot0=;
        b=ISB02kpYwF1Nij+6MHRElz2AaGhBWydpO/QLCgyqZWIcz3G+rU1b+JRvbw5mtlHQCS
         w0O1pUq+u77R/2d56sk5neAqdnhT281oHFIAgewLTUHc7+TeLh88wQxeuXI7e094ApcF
         I39fFOmS6Bj1O16S8hSTjhsFq/bX6rshmBiF8=
Received: by 10.68.74.35 with SMTP id q3mr46328101pbv.107.1323802395199; Tue,
 13 Dec 2011 10:53:15 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Tue, 13 Dec 2011 10:52:34 -0800 (PST)
In-Reply-To: <7vwra0uxqo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187043>

On Tue, Dec 13, 2011 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Dec 13, 2011 at 01:10:26PM +0100, Erik Faye-Lund wrote:
>>
>>> +int xsetenv(const char *name, const char *val, int overwrite)
>>> +{
>>> + =A0 =A0if (setenv(name, val, overwrite))
>>> + =A0 =A0 =A0 =A0 =A0 =A0die_errno("setenv failed");
>>> +}
>>
>> It probably doesn't matter, because the error condition is almost
>> certainly just "oops, we ran out of memory". But you could also prin=
t
>> the name of the variable being set, which may give the user a clue t=
o
>> some misconfiguration (e.g., trying to put some extremely long value
>> into the environment).
>
> Do we have enough memory to format that message in that situation ;-)=
?

We could. Running out of environment space is not the same as running
out of memory. For instance, Windows has a maximum environment size of
32 kB. Older Linux kernels maxed out at 128 kB.

So I think it's a good idea to at least try. The worst that can happen
is another, less descriptive error, no?
