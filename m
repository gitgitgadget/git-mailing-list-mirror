From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/17] revert: Save command-line options for continuing operation
Date: Tue, 12 Jul 2011 11:26:46 +0530
Message-ID: <CALkWK0kxnN_vcvaetOFw1Ouj7vj3mQ2DjPWv5v_9_a5UNjFooQ@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-13-git-send-email-artagnon@gmail.com> <7vei1wbjji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:57:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVy5-00085k-Je
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab1GLF5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 01:57:08 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53166 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab1GLF5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 01:57:07 -0400
Received: by wwg11 with SMTP id 11so2787655wwg.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=emfTPddzEol3dfjAsR6kWw0fis7TgzUaw8W/a/PVlFI=;
        b=AWW5QQYD+m/e3WsDsHv959rkQxc3QbnqNWfFJ+706ga3TFXSnP6e7fVRxrLz+I53tN
         TVug06ihH1WK+WbM7xad9vCKP4KJGYGNtiikadmTx+vQNOYIzfT2i+j25OY0Xh/+2d/e
         mfY5Hf3nTe11MNpkrh3xDG8aod7qvXPdlZ4S8=
Received: by 10.216.187.75 with SMTP id x53mr3733783wem.92.1310450226118; Mon,
 11 Jul 2011 22:57:06 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 22:56:46 -0700 (PDT)
In-Reply-To: <7vei1wbjji.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176918>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> + =C2=A0 =C2=A0 die(_("Malformed options sheet: %s"), git_path(SEQ_O=
PTS_FILE));
>> +}
>> +
>> +static void read_populate_opts(struct replay_opts **opts_ptr)
>
> It would make sense to refactor config.c:git_parse_file() to be easie=
r to
> use, rename it to be more descriptive (it should be a function that t=
akes
> a struct that holds these fields
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static FILE *config_file;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static const char *config_file_name;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static int config_linenr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static int config_file_eof;
>
> in addition to the callback "fn" and callback "data", expects the fil=
e to
> be in something similar to the .ini format, parses it with the help f=
rom
> the callback function), and use it here, without rolling your own.

Yes, and I'm working on it.  However, it'll probably take me more than
a few iterations to get the patch right- I didn't want the options
parser to be blocked by that.

> Also I get
>
> builtin/revert.c:682: error: 'read_populate_todo' defined but not use=
d
> builtin/revert.c:848: error: 'read_populate_opts' defined but not use=
d
>
> at this step in the series, which is not quite optimal.

Ah, yes.  I was going to ask about this:
"revert: Save data for continuing after conflict resolution"
introduces read_ and save_ counterparts for todo
"revert: Save command-line options for continuing operation"
introduces read_ and save_ counterparts for opts
The read_ counterparts of both are only used much later in "revert:
Introduce --continue to continue the operation"

Now I could introduce the read_ functions in the last patch, but that
wouldn't be very elegant -- I want to show people how to read the
todo/ opts file in the same patch where I first announce and show
people how to write them.  Does that make sense?  What do you suggest?
 Something like the GCC "unused"?

Thanks.

-- Ram
