From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Thu, 3 Feb 2011 22:48:15 +0700
Message-ID: <AANLkTikywtYzQorKPQoGNjWgyC9=iZAqNe-YfFsaczu_@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102020322.00171.johan@herland.net> <AANLkTinrqCaD_vg7Ah4Tjgoa-njEBEmiYt15ojtsazKw@mail.gmail.com>
 <201102031410.58623.johan@herland.net> <AANLkTindnAFix+u3HKW0V-ArkzjyrDhpmN6gf9PSj0_G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 16:49:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl1Qa-0007Cg-I0
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 16:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab1BCPsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 10:48:55 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35231 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab1BCPsy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 10:48:54 -0500
Received: by eye27 with SMTP id 27so702686eye.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=RKplMiuZA2wNUh2fg8cDiU44f3zYhtocM/6/mUfK7R0=;
        b=pnH5faDAY2kENRk1uGUBRfFEe5DbiVKDsYx9AWbWh1wLYIi4pS1f/yhwv6V9eKCft0
         8e+mCOlBbb2LOVLl6JygwIIGjxThjQfy9UMTq68MaJOXyLjIgMnENorGL6blrNAnE01s
         Z1NOhQs/Blyt/sDJOSRtY6SX7I6+stKAZaNpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iKQsN085FwUaJdWam91WNKS1hWt2nUVgUcMMi9CBVNmxk/KUFqYXakLj4BxxmBImUA
         INM14+aPELjBDdOUt0/pOmGHDkMO6r/UT2ngmJcv/FRQM4xs56tL91AOd+4OkwM3fIvC
         6yVj8syuuKlKbvWJfsnN1oWnVc70lMfRVDgTE=
Received: by 10.216.24.135 with SMTP id x7mr861771wex.43.1296748129987; Thu,
 03 Feb 2011 07:48:49 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 3 Feb 2011 07:48:15 -0800 (PST)
In-Reply-To: <AANLkTindnAFix+u3HKW0V-ArkzjyrDhpmN6gf9PSj0_G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165980>

On Thu, Feb 3, 2011 at 9:10 PM, Santi B=C3=A9jar <santi@agolina.net> wr=
ote:
>> On Thursday 03 February 2011, Nguyen Thai Ngoc Duy wrote:
>>> On Wed, Feb 2, 2011 at 9:21 AM, Johan Herland <johan@herland.net>
>> wrote:
>>> > Migration plan:
>>> > ...
>>> > In v1.8.0, we should default to the new default refspecs when
>>> > creating new remotes. However, existing remotes (created
>>> > pre-v1.8.0) must continue to work as before, so we cannot simply
>>> > remove the implicit refspecs (or tag auto-following). Instead we
>>> > need to make sure that the implicit refspecs is NOT applied to th=
e
>>> > new-style remotes. Identifying new-style vs. old-style remotes ca=
n
>>> > be done by looking at the refspec itself (old-style:
>>> > "refs/remotes/$remote/*", new-style:
>>> > "refs/remotes/$remote/heads/*"), or (worst case) by introducing a
>>> > config variable specifying the desired behavior (defaulting to
>>> > old-style).
>>>
>>> I'd prefer config var (remote.*.implicitRules, maybe). We don't
>>> reserve heads, tags... in remote namespace for ourselves. Some user=
s
>>> might have already have branches heads/ant, heads/bee... making new
>>> style detection unreliable.
>
> I don't quite follow the argument. For me the question is how likely
> an old-time user has modified the refspec to read
> "refs/remotes/$remote/heads/* (new-style). I think this is very, very
> unlikely and thus the "heuristic" to detect old/new style works most
> of the time and there is no need for a new config/compatibility key.

Personally I don't have any repos that weird, so it's no problem to
me. Maybe I'm overengineering.
--=20
Duy
