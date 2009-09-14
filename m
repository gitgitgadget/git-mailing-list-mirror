From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 15:12:43 +0200
Message-ID: <40aa078e0909140612w71ad3bdeyfa94838cb57cec19@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
	 <20090914105750.GB9216@sigill.intra.peff.net>
	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
	 <20090914120311.GA17172@sigill.intra.peff.net>
	 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
	 <4AAE4087.5030607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:13:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBN4-0004XM-4h
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbZINNMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420AbZINNMm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:12:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43744 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbZINNMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:12:40 -0400
Received: by bwz19 with SMTP id 19so2061519bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0rOZbZYbi0JILjN0vQpoNDGp0LedZJhQ6cEu3QRMxk0=;
        b=VHOqnhw/tbFgsO48UdDOjvryaIny8KodnjPkfq/Xf0IVQ8aJXYu38/sXHOHkQH7UGD
         fjHosK+jLEoye1BDn96pENu9DMQi2m9zn44pTY+Ld4MmLcVjDYWzZkHVoEPBSD/8loAt
         HnPVU3FI0hyyO5rBeQ0wB/QE8ZY7/VYFpUTn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=s3TFly9LXizcnfeMmfRTg0fopiffjsMVkHmVRY40quTODhkMuCzyH4UCt6ig+eSpD4
         fsQhsU5/8rqpnhcjfcDDLwjjQU1Vtdx+Ol/XNp0r1RRHqR7z0UFTcBVCOQZPL3yGwki5
         i2na4CfZ5cubcUIUWsIOgl1ypkZ4+CYk8OonI=
Received: by 10.204.34.70 with SMTP id k6mr5134870bkd.178.1252933963326; Mon, 
	14 Sep 2009 06:12:43 -0700 (PDT)
In-Reply-To: <4AAE4087.5030607@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128474>

On Mon, Sep 14, 2009 at 3:09 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Erik Faye-Lund schrieb:
>> Compiling the following code gives a warning about unreachable code,
>> so it's clear that msvc doesn't simply ignore the directive. I'm not
>> saying that anyone suggested otherwise, I just wanted to know for
>> sure.
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> void (*exit_fun)(int) = exit;
>> void __declspec(noreturn) die(void);
>> void die(void) { exit_fun(1); }
>> int main(void) { printf("hello!\n"); die(); printf("world!\n"); }
>
> In order to countermand any clever optimizations you should make it
>
> -void (*exit_fun)(int) = exit;
> +extern void (*exit_fun)(int);
>
> (of course, this fails to link). But if this results in only *one* warning
> (that the printf() call is unreachable), then I wouldn't bother with this
> problem anymore, because you really should also have been warned that a
> __declspec(noreturn) function actually does return.

Ah, good point. Still gives the warning (as well as the linker-error), though.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
