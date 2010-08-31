From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] test-lib: use subshell instead of cd $new && .. && cd $old
Date: Tue, 31 Aug 2010 18:11:30 +0000
Message-ID: <AANLkTim7KWTR0FhnucZ7ROujZ-c7=y80Wz7UnR=+hsgZ@mail.gmail.com>
References: <1283169642-21917-1-git-send-email-avarab@gmail.com>
	<20100830155723.GC3292@burratino>
	<7vaao2br58.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Carl Worth <cworth@cworth.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVJ6-0000BT-LG
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab0HaSLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 14:11:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64355 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab0HaSLb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:11:31 -0400
Received: by fxm13 with SMTP id 13so4148161fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nLni+O1e79sgqsD+RJnsYI++VOLXRXiDiREBp79ZG9Y=;
        b=gPtrG3ceIhJUG+GHACj4Mgw0/F8fdwo5hjRYL4oMpATkYaBvwStf/gyGpuprLRwDZk
         JTHwwKT/WB+qDV1R+6oETmt+g1KYUM4jpRBLj+JiOSjQ1jQpu/A2TzYP0DiYnNcHLqJ1
         ByX/3t2dWmKPSEenGFkir8xGXZJ0TP48ZXQ1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pVF6yY1q5nGc3XlsTbBTOUWCQJyKxVKEqQPaaaTcCIuUismv01/XmigHchqgW1Hc8W
         HrOkZjQCzifZ4gSnv01Rl4V6opQZKz89fpD0DPXXcDbq0o5Mrl0C4rrbGUITg5ZPYqZ0
         i2nUvW+V6UkU8vp5nuDeYPx+SqM5NcV2C2/mc=
Received: by 10.223.124.205 with SMTP id v13mr878444far.24.1283278290324; Tue,
 31 Aug 2010 11:11:30 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 11:11:30 -0700 (PDT)
In-Reply-To: <7vaao2br58.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154953>

On Tue, Aug 31, 2010 at 17:58, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> +++ b/t/test-lib.sh
>>> @@ -687,14 +687,12 @@ test_when_finished () {
>>> =C2=A0test_create_repo () {
>>> =C2=A0 =C2=A0 =C2=A0test "$#" =3D 1 ||
>>> =C2=A0 =C2=A0 =C2=A0error "bug in the test script: not 1 parameter =
to test-create-repo"
>>> - =C2=A0 =C2=A0owd=3D`pwd`
>>> =C2=A0 =C2=A0 =C2=A0repo=3D"$1"
>>> =C2=A0 =C2=A0 =C2=A0mkdir -p "$repo"
>>> - =C2=A0 =C2=A0cd "$repo" || error "Cannot setup test environment"
>>> + =C2=A0 =C2=A0(cd "$repo" || error "Cannot setup test environment"
>>> =C2=A0 =C2=A0 =C2=A0"$GIT_EXEC_PATH/git-init" "--template=3D$GIT_BU=
ILD_DIR/templates/blt/" >&3 2>&4 ||
>>> =C2=A0 =C2=A0 =C2=A0error "cannot run git init -- have you built th=
ings yet?"
>>> - =C2=A0 =C2=A0mv .git/hooks .git/hooks-disabled
>>> - =C2=A0 =C2=A0cd "$owd"
>>> + =C2=A0 =C2=A0mv .git/hooks .git/hooks-disabled)
>>
>> Style: why not use
>>
>> =C2=A0 =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd "$repo" ...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... .git/hooks-disa=
bled
>> =C2=A0 =C2=A0 =C2=A0 )
>
> That is a sensible suggestion, but what does "error" do?
>
> I think you would need || exit at the end, i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... || error "=
=2E.."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) || exit
>
> or something.

Good catch, yes. error() calls exit so this patch as-is introduces a
logic error.
