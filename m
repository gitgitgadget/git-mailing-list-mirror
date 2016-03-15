From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Tue, 15 Mar 2016 13:24:31 -0700
Message-ID: <xmqqlh5j7am8.fsf@gitster.mtv.corp.google.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
	<CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
	<CAFZEwPP5AXHCmAg62wVNy_8FuOQxPdYofeb5b=m3g-ugiJkTyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 21:24:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afvWB-0002c0-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 21:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbcCOUYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 16:24:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752321AbcCOUYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 16:24:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8398D4D429;
	Tue, 15 Mar 2016 16:24:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B3ShSLDVACysUiw+M3uM6tysMBQ=; b=hOeNXM
	N/eqFhp+f486ihhceBW4CwpHmAQlH5P+XIK7ZZdIk0N4uPQHd8uzOJZzCpUjG/Vv
	MuEEvOwmJdxQ6b45RHa1X7K8+aSk/Nm88s65NzOU2Tu01o5IYvcCJT7Ezw+SfxL0
	Wrc80urNqMRyO+6Q3eLH1BjovK5pN5o3ujqrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gl2wk6JGIy6jltfTQxuAaGiUbOid17ZA
	OtPuWRLYtVLIvDexzI4A7isNc1upJyb2gbylKQOuXeGLU45ff5c7jD0/J9I5BQPw
	6wsyafn/Geq/Ukkigvp5Kka+GLCiM2VgQR20vYlGnyKZqsXi0GIUmODbQrj7zbzZ
	EFxld57Eup0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79AFA4D427;
	Tue, 15 Mar 2016 16:24:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F3F6C4D426;
	Tue, 15 Mar 2016 16:24:32 -0400 (EDT)
In-Reply-To: <CAFZEwPP5AXHCmAg62wVNy_8FuOQxPdYofeb5b=m3g-ugiJkTyw@mail.gmail.com>
	(Pranit Bauva's message of "Wed, 16 Mar 2016 01:43:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDA8D72E-EAEB-11E5-9AE3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288909>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> First one to introduce a new variable `config_verbose` to store the
> value read by the config. Till then the value of verbose can be set
> through command line options. Depending on the situation as you
> described, it can then make the modification. Another approach would
> be to swap the places where the configuration file is read and where
> arguments are parsed. I personally think the first approach as more
> appropriate as in the latter one, there might be some parts of code
> which can break.

Changing config-first-and-then-command-line is likely to break
things, unless you do a lot more work to avoid breakage ;-)

Wouldn't it be the simplest to do:

 * initialize opt-verbose to "unspecified";
 * initialize config-verbosity to "unspecified";
 * let git_config() update config-verbosity;
 * let parse_options() update opt-verbose.

and then

 * if opt-verbose is still "unspecified", then overwrite it with
   config-verbosity.

 * if opt-verbose is still "unspecified" after that, then neither
   the command line nor the configuration gave you verbosity.

 * otherwise opt-verbose at this point has what verbosity level to
   use.

?
