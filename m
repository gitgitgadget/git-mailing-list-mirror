From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 2/3] fast-import: add option command
Date: Fri, 14 Aug 2009 09:37:57 -0700
Message-ID: <fabb9a1e0908140937h32a2eac7ka88f76aa417fd631@mail.gmail.com>
References: <1250190156-4752-1-git-send-email-srabbelier@gmail.com> 
	<1250190156-4752-2-git-send-email-srabbelier@gmail.com> <1250190156-4752-3-git-send-email-srabbelier@gmail.com> 
	<20090814153707.GT1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 18:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbznO-0005D1-G8
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 18:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbZHNQiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 12:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbZHNQiR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 12:38:17 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34577 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbZHNQiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 12:38:17 -0400
Received: by ewy10 with SMTP id 10so1630007ewy.37
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eRKuNcVQJiLng9HGdl/2RFbbhf47N5V3Zt7q/H7py7E=;
        b=Bpwsq8HSYUc3AY2FR7DSxfkVYHsQ5olIkm3SfF91oPVywQ5aqO5dsQn+dA8Vd3VXe1
         W7UKmX8ZzCp1a/C2w834m5MWoqpYMj5p0xbrPwAHp0dCE2W52/DfkDXn9S01MBaw0NzQ
         iKJM2qrK1uKg/DSef70XY+5BeQ9lMyeIWa5Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R8g8iJvlHA4PhclUSlSxjCAogVXU/EVLjNceD8yzmhv+sf+jD4noZ9DBTkHJpBd2HT
         ZmMr9DRv5BSr/CYDKxvOEQskwR+nrgjsXTYrNqI8M+p0L5jUH33ohUnY++RUirwjSucY
         xzBovYx1/cNO4QjxuSsM0IEK9alTXU2QT8xcw=
Received: by 10.216.1.69 with SMTP id 47mr485977wec.224.1250267897097; Fri, 14 
	Aug 2009 09:38:17 -0700 (PDT)
In-Reply-To: <20090814153707.GT1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125937>

Heya,

On Fri, Aug 14, 2009 at 08:37, Shawn O. Pearce<spearce@spearce.org> wro=
te:
> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> +`option`
>> +~~~~~~~~
>> +Processes the specified option so that git fast-import behaves in a
>> +way that suits the frontend's needs.
>> +Note that options specified by the frontend are overridden by any
>> +options the user may specify to git fast-import itself.
>
> Wha? =A0This disagrees with the code.

It does? It's saying that the user my override what the frontend
specifies, which is what the current version does.

> This is a nasty refactoring, I would prefer to see it done in its
> own commit, "move option_import_marks so it can be called during
> command processing".

Ok, will do.

>> + =A0 =A0 // argv hasn't been parsed yet, do so
>> + =A0 =A0 if (!seen_non_option_command)
>> + =A0 =A0 =A0 =A0 =A0 =A0 parse_argv();
>
> This is too late.

No it's not. Earlier in the patch, at the other
'seen_non_option_command', we call parse_argv() as well (which happens
when a non-option command is issued). This statement is here to deal
with options that affect an empty stream, such as 'git format-patch
--import-marks=3Dmarks.old --export-marks=3Dmarks.new < /dev/null &&
test_cmp marks.old marks.new'.

> So yea, I really do think its a good idea for command line options
> to override stream options, despite what Dscho may think. =A0:-)

Which is what the current version does, yes?

--=20
Cheers,

Sverre Rabbelier
