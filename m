From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 3/4] enter_repo: do not modify input
Date: Thu, 6 Oct 2011 15:06:04 +0200
Message-ID: <CABPQNSZFo7u5GBvZzhKDzR5YGYwd0j8-Mb080QymDu9ayV6uDA@mail.gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
 <1317329963-6656-4-git-send-email-kusmabite@gmail.com> <CABURp0qDsxHwsuyvB6-KvKPrKuUT0-Fpr730TD_TxxFY7fotpA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	gitster@pobox.com, rene.scharfe@lsrfire.ath.cx
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnf0-0002eC-QJ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758352Ab1JFNGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 09:06:46 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63415 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262Ab1JFNGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 09:06:45 -0400
Received: by qyk30 with SMTP id 30so5267107qyk.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=6NggQDX/mK8TnXjUgDoAbropP6B8/hYM0kW6enyOZKM=;
        b=AjFtKGSIQRsI7oYEzk5CI5wNgUUkKplpB4SmF8iarg5adabUQqQUvejfLNBizOt/Xi
         Hbj7Yq1KnV68oGVKYBfNNEozjAN68oxR+Q6Swmvj3yavyPEq3RZ9/OAFDaLoTsKiBwci
         uWLN4cWgJQslI7dzOlBGYO4+cAtJ364USiRYw=
Received: by 10.68.33.163 with SMTP id s3mr5950179pbi.10.1317906404374; Thu,
 06 Oct 2011 06:06:44 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 6 Oct 2011 06:06:04 -0700 (PDT)
In-Reply-To: <CABURp0qDsxHwsuyvB6-KvKPrKuUT0-Fpr730TD_TxxFY7fotpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182942>

On Tue, Oct 4, 2011 at 7:55 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Thu, Sep 29, 2011 at 4:59 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> entr_repo(..., 0) currently modifies the input to strip away
>> trailing slashes. This means that we some times need to copy the
>> input to keep the original.
>
> I'm also modifying enter_repo() so I'm looking a bit closer at this p=
atch now.
>
>> Change it to unconditionally copy it into the used_path buffer so
>> we can safely use the input without having to copy it.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
> [...]
>> =A0*/
>> -char *enter_repo(char *path, int strict)
>> +const char *enter_repo(const char *path, int strict)
>> =A0{
>> =A0 =A0 =A0 =A0static char used_path[PATH_MAX];
>> =A0 =A0 =A0 =A0static char validated_path[PATH_MAX];
>> @@ -297,14 +297,15 @@ char *enter_repo(char *path, int strict)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int len =3D strlen(path);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int i;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((1 < len) && (path[len-1] =3D=3D=
 '/')) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path[len-1] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((1 < len) && (path[len-1] =3D=3D=
 '/'))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len--;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (PATH_MAX <=3D len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (path[0] =3D=3D '~') {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *newpath =3D expa=
nd_user_path(path);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(used_path, path, len);
>
> When len < strlen(path), this will will leave used_path unterminated.
>

Good catch, thanks!

>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (used_path[0] =3D=3D '~') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *newpath =3D expa=
nd_user_path(used_path);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!newpath || (PATH=
_MAX - 10 < strlen(newpath))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(=
newpath);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retur=
n NULL;
>> @@ -316,24 +317,21 @@ char *enter_repo(char *path, int strict)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * anyway.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(used_path, new=
path); free(newpath);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(validated_path,=
 path);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path =3D used_path;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(validated_path,=
 used_path);
>
> The point of 'validated_path' is to keep the original unmolested,
> unexpanded path string (plus DWIM suffix), but here you've just
> replaced validated_path with a copy of the expanded_user_path. =A0On =
the
> other hand, we seem always to strcpy(validated_path , path), so we
> might as well get that done up-front.

Yeah, that's probably better.
