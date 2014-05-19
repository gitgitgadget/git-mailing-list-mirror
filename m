From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Returning error message from custom smart http server
Date: Mon, 19 May 2014 18:12:10 +1000
Message-ID: <CAGyf7-EoSgTxZzReFArOgcrBaARv7fRiZTMPZX+Loy9dec23aQ@mail.gmail.com>
References: <5371CC4F.80602@intland.com>
	<20140516230116.GC180798@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?w4Frb3MsIFRhanRp?= <akos.tajti@intland.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 19 10:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmIge-0008Pd-Gx
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 10:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbaESIMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 04:12:39 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40999 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752757AbaESIML convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 04:12:11 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]) (using TLSv1) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKU3m82vVYACGPnSIP+Ugkfm3DbpixBq1q@postini.com; Mon, 19 May 2014 01:12:11 PDT
Received: by mail-ob0-f182.google.com with SMTP id wn1so5831823obc.27
        for <git@vger.kernel.org>; Mon, 19 May 2014 01:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=ptPjaCj37OPCrndu7Zn2a/f826HuVoHXtbWCUwOonBQ=;
        b=hugI9sHBbpHSTSPPPuRPfTZgiyHtqK64zf3TFO+3MMvvXvERd54jOZ+p8fn5MGKi9g
         rlJDH6hdB3j6QJwM7Y3TkZXcIOHMsHuoNunaH3pN+/w3xazqcawzQHPKuvJ34qO0zzbX
         WfDjL7Au7CbjUPjJ92sjh8OwfoKN3oPbAKdrNSQMMGXZCo0Jt6gYGtBXQ23VKFvlFkne
         5AsLWRQQaLI647LYfCUuQcwVYYDnGJlgFkNionVQd9eX8kznkLn0mkmW92wZFeQ4H7aB
         EmzPkoTFN4SvLc4/ZQ8u7+A7eHVXPZgXHzLBHe86foebqcS1A9vkdGYC/U1eKe6x3FIy
         TtSQ==
X-Gm-Message-State: ALoCoQm4AoYoU5tEgPUGP2jFJqOyRPrlTI0Qjp2ahd07wtz2fdlDJYor/Awe43Hpth2WPjTDK/lZUzZd0txDIIvGDgWfYq+uX6mXO5voNwWWQ+ETMtt0SExzD9zLb08y/I29BInnRrZ0
X-Received: by 10.60.118.4 with SMTP id ki4mr4183460oeb.10.1400487130651;
        Mon, 19 May 2014 01:12:10 -0700 (PDT)
X-Received: by 10.60.118.4 with SMTP id ki4mr4183451oeb.10.1400487130520; Mon,
 19 May 2014 01:12:10 -0700 (PDT)
Received: by 10.182.114.196 with HTTP; Mon, 19 May 2014 01:12:10 -0700 (PDT)
In-Reply-To: <20140516230116.GC180798@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249565>

On Sat, May 17, 2014 at 9:01 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, May 13, 2014 at 09:39:59AM +0200, "=C3=81kos, Tajti" wrote:
>> Dear List,
>>
>> we implemented our own git smart http server to be able to check per=
missions
>> and other thing before pushes. It works fine, however, the error mes=
sages we
>> generate on the server side are not displayed by the command line cl=
ient. On
>> the server we generate error messages like this:
>>
>>         response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
>>         response.getWriter().write(msg);
>>
>> On the command line we get this:
>>
>> Total 0 (delta 0), reused 0 (delta 0)
>> POST git-receive-pack (290 bytes)
>> efrror: RPC failed; result=3D22, HTTP code =3D 401
>> atal: The remote end hung up unexpectedly
>> fatal: The remote end hung up unexpectedly
>>
>> The server message is completely missing. Is there a solution for th=
is?

You should not need a patched git; the wire protocol itself has a
mechanism for sending "smart" error messages. It's not particularly
_obvious_, but it's there.

=46or starters, to return an error message, your status must be 200 OK.
You can't return any other status code or Git will interpret your
error as some form of _HTTP_ error rather than a _git_ error.

In the smart protocol the client sends a service to the server as a
query parameter, like "?service=3Dgit-receive-pack". For such a request=
,
you need to:
- Set the content type to "application/x-<service>-advertisement"
(e.g. "application/x-git-receive-pack-advertisement") (Not all command
line Git versions require this, but JGit does)
- Set the status code as 200 OK
- Write back a payload where the first 4 bytes are the hex-encoded
length of the text (where "FFFF" is max length for a single packet).
Note that the 4 bytes for the size are _part_ of that length, so if
you're writing "Test" the length is 8, not 4
- After the size, you write "# service=3D<service>" (e.g. "#
service=3Dgit-receive-pack"; note the space after the #) This is the
metadata. For an error, you don't really have much to say.
- After that, an empty packet, which is "0000" (four zeros) This
separates the metadata from the ref advertisement
- After that you can write your message, beginning with "ERR " (note
the trailing space there). The "ERR " tells Git what you're writing
isn't a ref, it's an error. I'd recommend appending a newline (and add
1 more to your length for it), because when Git echoes your error
message it doesn't seem to do that

I'm not sure whether there's a document that describes all of this; I
found it by digging into the Git source code (you can find the "ERR"
handling in connect.c, get_remote_heads). This may be exploiting the
protocol, I'll leave that to someone more knowledgeable on how they
_intended_ this all to be used, but it works for us.

A full example looks something like this: "0036#
service=3Dgit-receive-pack0000ERR This is a test\n"

Hope this helps,
Bryan Turner

>
> It does look that way.  Does the following patch work for you?
>
> -- >8 --
> Subject: [PATCH] http: provide server's error message on RPC failure
>
> The server might provide a custom error message that is useful to the=
 user.
> Provide this message to the user if HTTP RPC fails.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  remote-curl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 52c2d96..5984d35 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -426,8 +426,8 @@ static int run_slot(struct active_request_slot *s=
lot,
>         err =3D run_one_slot(slot, results);
>
>         if (err !=3D HTTP_OK && err !=3D HTTP_REAUTH) {
> -               error("RPC failed; result=3D%d, HTTP code =3D %ld",
> -                     results->curl_result, results->http_code);
> +               error("RPC failed; result=3D%d, HTTP code =3D %ld (%s=
)",
> +                     results->curl_result, results->http_code, curl_=
errorstr);
>         }
>
>         return err;
> -- >8 --
>
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion o=
nly
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B=
187
