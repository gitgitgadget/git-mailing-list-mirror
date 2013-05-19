From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-hg: set stdout to binary mode on win32
Date: Sun, 19 May 2013 00:48:42 -0700
Message-ID: <7v8v3bz9yd.fsf@alter.siamese.dyndns.org>
References: <CAFGOX=V0A=2kMpxtNvsjgEtMt=zsm_-zX_DJo0qkV9y1_C4Haw@mail.gmail.com>
	<CAMP44s3H5e3ffoA04pdJx-pfKMGiRBTmjAn6NceP+s6_TYo1GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Amit Bakshi <ambakshi@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 09:48:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdyML-0000jv-GX
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 09:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab3ESHsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 03:48:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab3ESHsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 03:48:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A08A1BC17;
	Sun, 19 May 2013 07:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sevKa/5yU+qV86vnHNZyWJxYCrI=; b=uYCqpF
	v5axtkb+7M9O8UQTyR5ApwT6n0D73N2IQnSuA2FLhBNQ0Fsk/84tALYj0CoeJRVA
	flxF4gTpz0TmPioth62kNKuJ4Ol/gN1n1J3+cEfJGAX0jhSnwy9EBMd4EzCOahjl
	YD+K77zwPc4Mk+Ak+sn2HtNhg5Xucj8rwa+ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjts3q1VznMIBgTqssPszGxzLm27ic4s
	ZmRqzN+62NC9Ni8u4MUdYKGeKDwNqvPA0+IoQaJpCxH8/ZrhIs6mYFM2YeIf7P6E
	J+YkNLjzsxuyY5MWPsDvChzTxP/LhcYPLeA4QrVW9CO5hk8ExZLRYr81xa5jY/FP
	763FRDSFJgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C051BC15;
	Sun, 19 May 2013 07:48:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D64EE1BC13;
	Sun, 19 May 2013 07:48:43 +0000 (UTC)
In-Reply-To: <CAMP44s3H5e3ffoA04pdJx-pfKMGiRBTmjAn6NceP+s6_TYo1GA@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 19 May 2013 00:33:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8795FAD6-C058-11E2-85B9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224827>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sorry Amit, I assumed this patch made it to the list, but I just
> realized it didn't; it doesn't allow HTML, and mails and silently
> dropped (I hate that).
>
> So I'm sending it so the list can see it:
>
> It seems OK for me, but I would like to try it, and so far I haven't
> managed to access Mercurial libraries at all from python scripts in
> Windows. What steps did you follow?

Thanks for keeping an eye on this part of the system.  It seems that
having an extra -rc cycle turned out to be not so bad an idea.



> On Mon, Jan 28, 2013 at 4:13 PM, Amit Bakshi <ambakshi@gmail.com> wrote:
>> git clone hangs on windows (msysgit/cygwin), and
>> file.write would return errno 22 inside of mercurial's
>> windows.winstdout wrapper class. This patch sets
>> stdout's mode to binary, fixing both issues.
>> ---
>>  contrib/remote-helpers/git-remote-hg | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg
>> b/contrib/remote-helpers/git-remote-hg
>> index 328c2dc..95f4c1f 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -62,6 +62,24 @@ def get_config(config):
>>      output, _ = process.communicate()
>>      return output
>>
>> +#
>> +# On Windows (msysgit/cygwin) have to set stdout to binary
>> +# mode (_O_BINARY is 32768). Otherwise clone hangs, and pushing
>> +# to remote fails when doing a write to mercurial's wrapper
>> +# windows.winstdout wrapper class.
>> +#
>> +def set_binmode(fd):
>> +    try:
>> +        if sys.platform == "win32":
>> +            import msvcrt
>> +            msvcrt.setmode(fd, os.O_BINARY)
>> +        elif sys.platform  == 'cygwin':
>> +            import ctypes
>> +            msvcrt = ctypes.CDLL('msvcrt.dll')
>> +            msvcrt._setmode(fd, 32768) # On Cygwin os.O_BINARY is different
>> +    except OSError:
>> +        pass
>> +
>>  class Marks:
>>
>>      def __init__(self, path):
>> @@ -764,6 +782,9 @@ def main(args):
>>      else:
>>          is_tmp = False
>>
>> +    if sys.platform in ['win32','cygwin']:
>> +        set_binmode(sys.stdout.fileno())
>> +
>>      gitdir = os.environ['GIT_DIR']
>>      dirname = os.path.join(gitdir, 'hg', alias)
>>      branches = {}
>> --
>> 1.8.1
