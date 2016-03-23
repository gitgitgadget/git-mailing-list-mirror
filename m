From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_name.c: add an option to abort on ambiguous refs
Date: Thu, 24 Mar 2016 06:11:00 +0700
Message-ID: <CACsJy8D7B0wRiBqz6G3vrpLKUEGaoBvzf_a97R1LVU0UrKQ2rw@mail.gmail.com>
References: <1458739840-15855-1-git-send-email-pclouds@gmail.com> <alpine.DEB.2.20.1603231642580.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 00:11:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1airw9-00071U-3N
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbcCWXLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 19:11:32 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33831 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcCWXLc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 19:11:32 -0400
Received: by mail-lb0-f170.google.com with SMTP id k12so19825449lbb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 16:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DTDWLMZZhO8q8GU/CdUZWQLWfJ3wwojyxu4NJh474co=;
        b=ESEGxnzZUCqszaY/9k8XpKXoqqb23pbkVoH+9B/CH2QM6KnbywXtoS7I7z2/tDWhIw
         M5g/2rCcJIl55Yl9t/m92kFfrGSnxQank6HsuSq9sDx3dihG5Kq6L0y9fFb8eHa7gjqa
         D3WbiICLuayH+Taog8R1UV0iN+CJwRgp28m6vBK8e99386vKiohCIxPBfkco0bG2U448
         ziAVGukX3da29/rWQ2/capGP1yymJjgMCWAk+5I4wTCWjRtDFpw7iLM8W7h33bck6vVp
         gvoyxuX5ct4eg0Q44hXjwcO+LebD3FwG7bOb8JS2P7veImD30QBwX0izxygzQGEaAgQj
         b/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DTDWLMZZhO8q8GU/CdUZWQLWfJ3wwojyxu4NJh474co=;
        b=mOfBPj+JmttQl3h5+3hDOZem6uVMAmkcY/MgX0uWYrxdXpzHGpwJbGV5fxxwNbadqW
         PDA+W1LkCNLVL5E6+rTBwmNAdFG3/sWyfPbOlpHWgf6Fa/DHcoR1rxq23hiybrNhdQsu
         I+RMMmXEmVsgTCwF376HnvHa3pezLGL/s2tZT0701QgzA+xahseTJHzgmIElCHa/ha/C
         CW6IlMrsTdv2Y11qPA/VSKeZi6TLQnU6fK14gA26IULBWn8iLxlJtleEyCwRm4JYo85V
         n2r0+pKzVcPWzyEE/q7wanYrEpAhiAgx2rdCfcJnGdsLaO4isRrz1JLSmOn2pHIbYekH
         BFhQ==
X-Gm-Message-State: AD7BkJL7W7489RmzSlqrlhANPTWTJxtErUxHyu3WJB28BcoSFGlby52jrxDyPIt2TRtp9sQ2NUqLuEC2U3kqEQ==
X-Received: by 10.112.140.129 with SMTP id rg1mr2316901lbb.80.1458774690316;
 Wed, 23 Mar 2016 16:11:30 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 23 Mar 2016 16:11:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603231642580.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289692>

On Wed, Mar 23, 2016 at 10:45 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Wed, 23 Mar 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> There are cases when a warning on ambiguous refs may go unnoticed
>> (e.g. git-log filling up the whole screen). There are also cases whe=
n
>> people want to catch ambiguity early (e.g. it happens deep in some
>> script). In either case, aborting the program would accomplish it.
>
> Whenever I see a die() in code outside of builtin/*.c, I cringe. I do=
 that
> because it was *exactly* something like that that caused a serious
> regression in the builtin am so that we had to resort back to spawnin=
g
> separate processes *just so* that we could catch error conditions and
> run certain code in that case.
>
> Maybe there would be a way to do what you want to do that does not fl=
y in
> the face of libification?

Sorry I got nothing better.

> Maybe some strbuf with an atexit() that
> accumulates fatal errors that might be hidden and that are then writt=
en at
> the end of the program (colorfully, if isatty(2))?

That sounds hacky. If you don't want do die() deep inside then the
callers have to handle it, but get_sha1() is spread everywhere. Plus I
do not want to program to succeed when there is ambiguation because
the ref git chooses may not be what I want. I want it to abort (and
almost made a patch that die() unconditionally).
--=20
Duy
