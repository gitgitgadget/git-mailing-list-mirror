From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 0/2] test-lib.sh: do tests for color support after changing HOME
Date: Tue,  6 Jan 2015 17:57:49 -0500
Message-ID: <1420585071-28973-1-git-send-email-rhansen@bbn.com>
References: <xmqq8uhfpw3s.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 06 23:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8d4p-0001BK-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 23:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbbAFW6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 17:58:02 -0500
Received: from smtp.bbn.com ([128.33.0.80]:63028 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbbAFW6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 17:58:00 -0500
Received: from socket.bbn.com ([192.1.120.102]:53246)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y8d4Z-000Nm2-HH; Tue, 06 Jan 2015 17:57:59 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 448683FF84
X-Mailer: git-send-email 2.2.1
In-Reply-To: <xmqq8uhfpw3s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262106>

On 2015-01-06T11:06-08:00, Junio C Hamano wrote:
>> +unset color
>>  while test "$#" -ne 0
>>  do
>>  	case "$1" in
>> @@ -258,40 +250,6 @@ then
>>  	verbose=t
>>  fi
>>  
>> -if test -n "$color"
>> ...
>> @@ -857,6 +815,52 @@ HOME="$TRASH_DIRECTORY"
>>  GNUPGHOME="$HOME/gnupg-home-not-used"
>>  export HOME GNUPGHOME
>>  
>> +# run the tput tests *after* changing HOME (in case ncurses needs
>> +# ~/.terminfo for $TERM)
>> +test -n "${color+set}" || [ "x$ORIGINAL_TERM" != "xdumb" ] && (
>
> OK, $color used to be boolean between '' (unset included) and 't',
> but now we do this after possibly processing the --no-color
> argument, so this is guarded slightly differently from the original.
>
> Makes sense.

I updated the commit message to make this change more obvious.

> This is a tangent but this patch shows 2 places out of the only
> three places we use [ ... ] construct (as opposed to a more
> traditionalist "test").  Perhaps we may want to fix them with a
> follow-up patch?

I added a prequel patch to address this.

Thank you for taking a look,
Richard


Richard Hansen (2):
  use 'test ...' instead of '[ ... ]'
  test-lib.sh: do tests for color support after changing HOME

 t/test-lib.sh | 92 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

-- 
2.2.1
